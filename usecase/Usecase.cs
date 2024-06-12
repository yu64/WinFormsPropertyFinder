using System;
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
    

    public List<(int, string)> GetTarget()
    {
        //プロパティ一覧から Visual Studioっぽい名称のものを取得する
        List<Process> targetLikeProcess = Process.GetProcesses()
        .Where(p => p.MainWindowHandle != IntPtr.Zero)
        .Where(p => p.MainWindowTitle.Contains("Microsoft Visual Studio"))
        .ToList()
        ;

        return targetLikeProcess
        .Select(p => (p.Id, p.MainWindowTitle))
        .ToList()
        ;
    }

    internal List<(string, string, string)> GetProperty(int targetProcessId)
    {
        var target = this.AttachProcess(targetProcessId);
        using var auto = new UIA3Automation();
        var table = this.FindTableElement(target, auto);
        
        var result = ElementWalker.Walk(table, new DataItemPathVisitor());
        result.ForEach(v => System.Console.WriteLine($"{v.Item2}, {v.Item1.Name}, {v.Item1.HelpText}"));

        return new()
        {
            ("終わり", "", "")
        };
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
            .Select(v => v.Item1)
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
    private AutomationElement FindTableElement(FlaUI.Core.Application target, AutomationBase auto)
    {
        //プロパティペインを取得
        var window = target.GetMainWindow(auto);
        var propertyBrowser = window.FindFirstDescendant(
            cf => cf.ByName("Property Browser", PropertyConditionFlags.MatchSubstring)
        );

        propertyBrowser = propertyBrowser ?? throw new Exception("プロパティペインが発見できません");
        
        //テーブル部分まで移動
        var propertyGrid = propertyBrowser.FindFirstChild(cf => cf.ByControlType(ControlType.Pane));
        var table = propertyGrid.FindFirstChild(cf => cf.ByControlType(ControlType.Table));
        
        return table;
    }

    


    


    //===================================================================================

}

