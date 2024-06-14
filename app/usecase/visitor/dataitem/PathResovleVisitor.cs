

using System.Collections.Immutable;
using FlaUI.Core.AutomationElements;
using static WinFormsPropertyFinder.PathResovleVisitor;

namespace WinFormsPropertyFinder;


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


    public void OnWalkStart()
    {
        this.nameQueue.Clear();
        this.path.ForEach(v => this.nameQueue.Enqueue(v));
        this.result.Clear();
    }

    public override void VisitRootElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        if(this.nameQueue.TryDequeue(out string? name))
        {
            walk(ele.FindFirstChild(cf => cf.ByName(name)));
        }
    }

    private protected override void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        ele.Patterns.Invoke.Pattern.Invoke();
        this.result.Add(ele);
        if(this.nameQueue.TryDequeue(out string? name))
        {
            walk(ele.FindFirstChild(cf => cf.ByName(name)));
        }
    }

    private protected override void VisitOpendCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.result.Add(ele);
        if(this.nameQueue.TryDequeue(out string? name))
        {
            walk(ele.FindFirstChild(cf => cf.ByName(name)));
        }
    }

    private protected override void VisitPropertyElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.result.Add(ele);
    }


    //======================================================================================================================


}