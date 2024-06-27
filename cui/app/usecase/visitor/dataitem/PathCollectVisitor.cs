using System;
using System.Collections.Immutable;
using FlaUI.Core.AutomationElements;
using FlaUI.Core.Definitions;
using static WinFormsPropertyFinder.cui.PathCollectVisitor;

namespace WinFormsPropertyFinder.cui;


public class PathCollectVisitor : AbstractDataItemVisitor<ImmutableList<VisitorResult>>
{
    //このVisitorの戻り値の定義
    public record VisitorResult(
        AutomationElement Element, 
        bool IsCollapse, 
        String ElementPath
    );


    private readonly Stack<string> currentPath = new();
    private readonly List<VisitorResult> result = new();
    public override ImmutableList<VisitorResult> Result => result.ToImmutableList();


    //設定
    private readonly string separator;
    private readonly bool ignoreClosedCollapseChildren;
    private readonly Rectangle? validRange;

    
    public PathCollectVisitor(
        string separator = ".", 
        bool ignoreClosedCollapseChildren = false,
        Rectangle? validRange = null
    )
    {
        this.separator = separator;
        this.ignoreClosedCollapseChildren = ignoreClosedCollapseChildren;
        this.validRange = validRange;
    }

    

    //======================================================================================================================


    private void WalkChildrenElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        var children = ele.FindAllChildren(cf => cf.ByControlType(ControlType.DataItem));
        foreach(var child in children)
        {
            //要素が有効であるか
            if(!this.IsValidElement(child))
            {   
                continue;
            }

            this.currentPath.Push(child.Name);
            walk(child);
            this.currentPath.Pop();
        }
    }

    private string GetPath()
    {
        return String.Join(this.separator, Enumerable.Reverse(this.currentPath));
    }

    private bool IsValidElement(AutomationElement ele)
    {
        bool withinValidRange = this.validRange?.IntersectsWith(ele.BoundingRectangle) ?? true;
        return withinValidRange;
    }



    //======================================================================================================================


    public override void OnWalkStart()
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
        //折り畳みの要素として保存
        this.result.Add(new(ele, true, this.GetPath()));

        //閉じられた折りたたみを無視する場合、内部に移動しない
        if(this.ignoreClosedCollapseChildren)
        {
            return;
        }

        //折り畳みを開く
        ele.Patterns.Invoke.Pattern.Invoke();

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


