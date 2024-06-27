

using System.Collections.Immutable;
using FlaUI.Core.AutomationElements;
using static WinFormsPropertyFinder.cui.PathResovleVisitor;

namespace WinFormsPropertyFinder.cui;


public class PathResovleVisitor : AbstractDataItemVisitor<ImmutableList<AutomationElement>>
{
    private readonly ImmutableList<string> path;
    private readonly Queue<string> nameQueue = new();
    private readonly List<AutomationElement> result = new();
    public override ImmutableList<AutomationElement> Result => this.result.ToImmutableList();


    public PathResovleVisitor(IEnumerable<string> path)
    {
        this.path = path.ToImmutableList();
    }


    //======================================================================================================================


    public override void OnWalkStart()
    {
        this.nameQueue.Clear();
        this.path.ForEach(v => this.nameQueue.Enqueue(v));
        this.result.Clear();
    }

    public override void VisitRootElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        //次へ
        if(this.nameQueue.TryDequeue(out string? name))
        {   
            var next = ele.FindFirstChild(cf => cf.ByName(name));
            if(next != null) walk(next);
        }
        
    }

    private protected override void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.result.Add(ele);
        if(this.nameQueue.TryDequeue(out string? name))
        {   
            //次が求められているので、折りたたみを開く
            ele.Patterns.Invoke.Pattern.Invoke();
            var next = ele.FindFirstChild(cf => cf.ByName(name));
            if(next != null) walk(next);
        }
    }

    private protected override void VisitOpendCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.result.Add(ele);
        if(this.nameQueue.TryDequeue(out string? name))
        {   
            var next = ele.FindFirstChild(cf => cf.ByName(name));
            if(next != null) walk(next);
        }
    }

    private protected override void VisitPropertyElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.result.Add(ele);
    }


    //======================================================================================================================


}