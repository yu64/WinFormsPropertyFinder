using System;
using FlaUI.Core.AutomationElements;
using FlaUI.Core.Definitions;
using static WinFormsPropertyFinder.DataItemPathVisitor;

namespace WinFormsPropertyFinder;


/// <summary>
/// FlaUI AutomationElement上のDataItemで構成された木構造を探索するクラス。
/// 探索結果をその要素と名前のパスで返す。
/// </summary>
public class DataItemPathVisitor : ElementVisitor<List<DataItemPathResult>>
{
    public record DataItemPathResult(AutomationElement Element, String ElementPath);

    private readonly string separator;
    private Stack<string> currentPath = new();
    private List<DataItemPathResult> summary = new();
    public List<DataItemPathResult> Result => summary;

    /// <summary>
    /// FlaUI AutomationElement上のDataItemで構成された木構造を探索するクラス。
    /// 探索結果をその要素と名前のパスで返す。
    /// </summary>
    /// <param name="separator"></param>
    public DataItemPathVisitor(string separator = ".")
    {
        this.separator = separator;
    }

    public void OnWalkStart()
    {
        this.currentPath = new();
        this.summary = new();
    }

    public void VisitRootElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        var children = ele.FindAllChildren(cf => cf.ByControlType(ControlType.DataItem));
        foreach(var child in children)
        {
            this.currentPath.Push(child.Name);
            walk(child);
            this.currentPath.Pop();
        }
    }

    public void VisitOpendCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        var children = ele.FindAllChildren(cf => cf.ByControlType(ControlType.DataItem));
        foreach(var child in children)
        {
            this.currentPath.Push(child.Name);
            walk(child);
            this.currentPath.Pop();
        }
    }

    public void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        ele.Patterns.Invoke.Pattern.Invoke();

        var children = ele.FindAllChildren(cf => cf.ByControlType(ControlType.DataItem));
        foreach(var child in children)
        {
            this.currentPath.Push(child.Name);
            walk(child);
            this.currentPath.Pop();
        }
    }

    public void VisitPropertyElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.summary.Add(new DataItemPathResult(ele, String.Join(this.separator, Enumerable.Reverse(this.currentPath))));
    }
}

