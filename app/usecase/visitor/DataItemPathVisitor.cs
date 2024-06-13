using System;
using System.Collections.Immutable;
using FlaUI.Core.AutomationElements;
using FlaUI.Core.Definitions;
using static WinFormsPropertyFinder.DataItemPathVisitor;

namespace WinFormsPropertyFinder;


/// <summary>
/// FlaUI AutomationElement上のDataItemで構成された木構造を探索するクラス。
/// 探索結果をその要素と名前のパスで返す。
/// </summary>
public class DataItemPathVisitor : ElementVisitor<ImmutableList<VisitorResult>>
{
    public record VisitorResult(AutomationElement Element, String ElementPath);

    private readonly string separator;
    private Stack<string> currentPath = new();
    private List<VisitorResult> summary = new();
    public ImmutableList<VisitorResult> Result => summary.ToImmutableList();

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


    //======================================================================================================================


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

    public void VisitOtherElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        var status = DataItemStatusHelper.GetDataItemStatus(ele);
        if (status == DataItemStatus.Open)
        {
            this.VisitOpendCollapseElement(ele, walk);
            return;
        }

        if (status == DataItemStatus.Close)
        {
            this.VisitClosedCollapseElement(ele, walk);
            return;
        }

        this.VisitPropertyElement(ele, walk);
    }
    

    //======================================================================================================================


    private void VisitOpendCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        var children = ele.FindAllChildren(cf => cf.ByControlType(ControlType.DataItem));
        foreach(var child in children)
        {
            this.currentPath.Push(child.Name);
            walk(child);
            this.currentPath.Pop();
        }
    }

    private void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
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

    private void VisitPropertyElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.summary.Add(new VisitorResult(ele, String.Join(this.separator, Enumerable.Reverse(this.currentPath))));
    }


    //======================================================================================================================

}

