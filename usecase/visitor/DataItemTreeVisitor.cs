using System;
using FlaUI.Core.AutomationElements;
using FlaUI.Core.Definitions;

namespace WinFormsPropertyFinder;


public class DataItemPathVisitor : ElementVisitor<List<(AutomationElement, string)>>
{
    private readonly string separator;
    private Stack<string> currentPath = new();
    private List<(AutomationElement, string)> summary = new();
    public List<(AutomationElement, string)> Result => summary;

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
        this.summary.Add((ele, String.Join(this.separator, Enumerable.Reverse(this.currentPath))));
    }
}
