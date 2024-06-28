using System;
using System.Collections.Immutable;
using System.Data;
using System.Diagnostics;
using System.Reflection.PortableExecutable;
using System.Runtime.Intrinsics.Arm;
using System.Security.Cryptography;
using System.Text;
using System.Windows.Forms;
using System.Windows.Forms.VisualStyles;
using FlaUI.Core;
using FlaUI.Core.AutomationElements;
using FlaUI.Core.Definitions;
using FlaUI.Core.Input;
using FlaUI.Core.Tools;
using FlaUI.Core.WindowsAPI;
using FlaUI.UIA3;
using FlaUI.UIA3.Converters;

namespace WinFormsPropertyFinder.cui;

public class Usecase
{

    private const string pathSeparator = ".";

    public Usecase()
    {

    }


    //===================================================================================
    

    internal ImmutableList<TargetInfo> GetTarget()
    {
        //プロパティ一覧から Visual Studioっぽい名称のものを取得する
        List<Process> targetLikeProcess = Process.GetProcesses()
        .Where(p => p.MainWindowHandle != IntPtr.Zero)
        .Where(p => p.MainWindowTitle.Contains("Microsoft Visual Studio"))
        .ToList()
        ;

        return targetLikeProcess
        .Select(p => new TargetInfo(p.Id, p.MainWindowTitle))
        .ToImmutableList()
        ;
    }

    internal ImmutableList<PropertyInfo> GetProperty(int targetProcessId)
    {
        //プロパティテーブルを取得
        var target = this.AttachProcess(targetProcessId);
        using var auto = new UIA3Automation();
        var table = this.FindPropertyTableElement(target, auto, true);

        //プロパティテーブルを探索し、プロパティを収集
        var result = ElementWalker.Walk(table, new PathCollectVisitor(pathSeparator));

        return result
        .Select(v => new PropertyInfo(v.ElementPath, this.GetPropertyValue(v.Element, ""), v.Element.HelpText))
        .ToImmutableList();
    }

    internal FocusInfo GetFocus(int targetProcessId)
    {
        //プロパティテーブルを取得
        var target = this.AttachProcess(targetProcessId);
        using var auto = new UIA3Automation();
        var window = target.GetMainWindow(auto);
        var propertyPane = this.FindPropertyPaneElement(window, false);
        var designerPane = this.FindDesignerPaneElement(window, false);

        //フォーカスの要素を取得
        var focus = auto.FocusedElement();

        return new FocusInfo(
            this.HashElement(focus),
            propertyPane?.BoundingRectangle.IntersectsWith(focus.BoundingRectangle) ?? false,
            designerPane?.BoundingRectangle.IntersectsWith(focus.BoundingRectangle) ?? false
        );
    }

    internal ImmutableList<PathInfo> FocusProperty(int targetProcessId, string propertyPath)
    {
        //プロパティテーブルを取得
        var target = this.AttachProcess(targetProcessId);
        using var auto = new UIA3Automation();
        var table = this.FindPropertyTableElement(target, auto, true);


        //プロパティテーブルを探索し、プロパティのパスを解決
        var pathItems = ElementWalker.Walk(table, new PathResovleVisitor(propertyPath.Split(pathSeparator)));
        var targetProperty = pathItems.Last();

        //選択する
        table.Focus();
        this.FocusProperty(targetProperty);

        return pathItems
        .Select(v => new PathInfo(v.Name))
        .ToImmutableList();
    }

    internal void WatchFocus(int targetProcessId, int interval, Func<bool> isStop, Action<ImmutableList<FocusInfo>> output)
    {
        //プロパティテーブルを取得
        var target = this.AttachProcess(targetProcessId);
        using var auto = new UIA3Automation();
        var window = target.GetMainWindow(auto);

        //フォーカス変化のリスナーを登録
        using var handler = auto.RegisterFocusChangedEvent(ele => {
            
            var propertyPane = this.FindPropertyPaneElement(window, false);
            var designerPane = this.FindDesignerPaneElement(window, false);

            var result = new FocusInfo(
                this.HashElement(ele),
                propertyPane?.BoundingRectangle.IntersectsWith(ele.BoundingRectangle) ?? false,
                designerPane?.BoundingRectangle.IntersectsWith(ele.BoundingRectangle) ?? false
            );

            output(ImmutableList.Create(result));
        });

        //待機
        while(!isStop())
        {
            Thread.Sleep(interval);
        }

    }





    //===================================================================================
    

    /// <summary>
    /// 有効なプロセスIDからプロセスを取得し、FlaUIを準備する
    /// </summary>
    /// <param name="targetProcessId"></param>
    /// <returns></returns>
    private FlaUI.Core.Application AttachProcess(int targetProcessId)
    {
        //使用可能なターゲットに含まれるか確認する
        bool isExist = this.GetTarget()
            .Select(v => v.ProcessId)
            .Any(id => id == targetProcessId);

        if(!isExist)
        {
            throw new Exception("不正なIDが指定されています");
        }

        //プロセスにアクセスする
        var targetProcess = Process.GetProcessById(targetProcessId);
        var target = FlaUI.Core.Application.Attach(targetProcess);
        if(target == null)
        {
            throw new Exception("プロセスにアクセスできません");
        }

        return target;
    }

    private AutomationElement FindPropertyPaneElement(AutomationElement ele, bool canThrow = true)
    {
        //プロパティペインを取得
        var output = ele.FindFirstDescendant(
            cf => cf.ByName("Property Browser", PropertyConditionFlags.MatchSubstring)
        );

        if(!canThrow)
        {
            return output;
        }

        return output ?? throw new Exception("プロパティペインが見つかりません");
    }

    private AutomationElement FindDesignerPaneElement(AutomationElement ele, bool canThrow = true)
    {
        //プロパティペインを取得
        var output = ele.FindFirstDescendant(
            cf => cf.ByName("DesignerFrame", PropertyConditionFlags.MatchSubstring)
        );

        if(!canThrow)
        {
            return output;
        }

        return output ?? throw new Exception("デザインペインが発見できません");
    }

    private AutomationElement FindPropertyTableElement(FlaUI.Core.Application target, AutomationBase auto, bool canThrow = true)
    {
        var window = target.GetMainWindow(auto);
        var propertyPane = this.FindPropertyPaneElement(window, canThrow);
        var grid = propertyPane.FindFirstChild(cf => cf.ByControlType(ControlType.Pane));
        var table = grid.FindFirstChild(cf => cf.ByControlType(ControlType.Table));

        if(!canThrow)
        {
            return table;
        }

        return table ?? throw new Exception("プロパティテーブルが発見できません");
    }



    private string GetPropertyValue(AutomationElement ele, string altValue)
    {
        return ele.Patterns.Value.PatternOrDefault?.Value ?? altValue;
    }
    

    private void FocusProperty(AutomationElement ele)
    {
        ele.Patterns.Invoke.PatternOrDefault?.Invoke();
        ele.Patterns.Invoke.PatternOrDefault?.Invoke();
        Keyboard.Type(
            VirtualKeyShort.UP,
            VirtualKeyShort.DOWN
        );
        Keyboard.Type(
            VirtualKeyShort.DOWN,
            VirtualKeyShort.UP
        );
        ele.Patterns.Invoke.PatternOrDefault?.Invoke();
        ele.Patterns.Invoke.PatternOrDefault?.Invoke();
    }

    
    private string HashElement(AutomationElement ele)
    {
        //ハッシュ値の元になる文字列
        var hashSeeds = ImmutableList.Create<string>(
            String.Format("{0}", ele.Properties.Name),
            String.Format("{0}", ele.Properties.ControlType.ToString()),
            String.Format("{0}", ele.Properties.ProcessId),
            String.Format("{0}", ele.Properties.BoundingRectangle.ToString()),
            String.Format("{0}", ele.Properties.AutomationId),
            String.Format("{0}", ele.Properties.FrameworkId.ToString())
        );

        //要素を定める文字列をバイト配列に変換
        var encoder = Encoding.GetEncoding("UTF-8");
        var textBytes = encoder.GetBytes(String.Join(", ", hashSeeds));

        //バイト配列をハッシュ値に変換
        using SHA256 sha256 = SHA256.Create();
        var hashBytes = sha256.ComputeHash(textBytes);
        var hashText = BitConverter.ToString(hashBytes).Replace("-", string.Empty);

        return hashText;
    }

    //===================================================================================

}

