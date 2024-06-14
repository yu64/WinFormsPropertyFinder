using System;
using System.Collections.Immutable;
using FlaUI.Core.AutomationElements;
using FlaUI.Core.Definitions;
using static WinFormsPropertyFinder.PathCollectVisitor;

namespace WinFormsPropertyFinder;


public class PathCollectVisitor : AbstractDataItemVisitor<ImmutableList<VisitorResult>>
{
    public record VisitorResult(AutomationElement Element, bool IsCollapse, String ElementPath);


    private readonly string separator;
    private readonly Stack<string> currentPath = new();
    private readonly List<VisitorResult> result = new();
    public override ImmutableList<VisitorResult> Result => result.ToImmutableList();

    public PathCollectVisitor(string separator = ".")
    {
        this.separator = separator;
    }

    

    //======================================================================================================================


    private void WalkChildrenElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        var children = ele.FindAllChildren(cf => cf.ByControlType(ControlType.DataItem));
        foreach(var child in children)
        {
            this.currentPath.Push(child.Name);
            walk(child);
            this.currentPath.Pop();
        }
    }

    private string GetPath()
    {
        return String.Join(this.separator, Enumerable.Reverse(this.currentPath));
    }



    //======================================================================================================================


    public void OnWalkStart()
    {
        this.currentPath.Clear();
        this.result.Clear();
    }

    public override void VisitRootElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.WalkChildrenElement(ele, walk);
    }

    private protected override void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        //折り畳みを開く
        ele.Patterns.Invoke.Pattern.Invoke();

        //折り畳みの要素として保存
        this.result.Add(new(ele, true, this.GetPath()));

        //内部へ
        this.WalkChildrenElement(ele, walk);
    }

    private protected override void VisitOpendCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        //折り畳みの要素として保存
        this.result.Add(new(ele, true, this.GetPath()));

        //内部へ
        this.WalkChildrenElement(ele, walk);
    }

    private protected override void VisitPropertyElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        //プロパティとして保存
        this.result.Add(new(ele, false, this.GetPath()));
    }



    //======================================================================================================================


}


