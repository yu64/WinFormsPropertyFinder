using System;
using System.Collections.Immutable;
using System.Data;
using System.Diagnostics;
using System.Reflection.PortableExecutable;
using System.Windows.Forms;
using FlaUI.Core;
using FlaUI.Core.AutomationElements;
using FlaUI.Core.Definitions;
using FlaUI.UIA3;

namespace WinFormsPropertyFinder;

public class Usecase
{
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
        var table = this.FindPropertyTableElement(target, auto);
        
        //プロパティテーブルを探索し、プロパティを収集
        var result = ElementWalker.Walk(table, new DataItemPathVisitor("."));

        return result
        .Select(v => new PropertyInfo(v.ElementPath, this.GetPropertyValue(v.Element, ""), v.Element.HelpText))
        .ToImmutableList();
    }

    internal ImmutableList<SetFocusInfo> FocusProperty(int targetProcessId, string propertyPath)
    {
        //プロパティテーブルを取得
        var target = this.AttachProcess(targetProcessId);
        using var auto = new UIA3Automation();
        var table = this.FindPropertyTableElement(target, auto);

        //プロパティテーブルテーブルを探索し、プロパティのパスを解決
        var result = ElementWalker.Walk(table, new DataItemPathResovleVisitor(propertyPath.Split(".")));
        
        var targetProperty = result.Last();
        targetProperty.Patterns.Invoke.Pattern.Invoke();

        return result
        .Select(v => new SetFocusInfo(v.Name))
        .ToImmutableList();
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



    /// <summary>
    /// プロパティペインのテーブル要素まで検索し、取得する
    /// </summary>
    /// <returns></returns>
    private AutomationElement FindPropertyTableElement(FlaUI.Core.Application target, AutomationBase auto)
    {
        //プロパティペインを取得
        var window = target.GetMainWindow(auto);
        var browser = window.FindFirstDescendant(
            cf => cf.ByName("Property Browser", PropertyConditionFlags.MatchSubstring)
        );

        browser = browser ?? throw new Exception("プロパティペインが発見できません");
        
        //テーブル部分まで移動
        var grid = browser.FindFirstChild(cf => cf.ByControlType(ControlType.Pane));
        var table = grid.FindFirstChild(cf => cf.ByControlType(ControlType.Table));
        
        return table;
    }


    private string GetPropertyValue(AutomationElement ele, string altValue)
    {
        return ele.Patterns.Value.PatternOrDefault?.Value ?? altValue;
    }
    


    


    //===================================================================================

}

