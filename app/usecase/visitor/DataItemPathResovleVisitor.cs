

using System.Collections.Immutable;
using FlaUI.Core.AutomationElements;
using static WinFormsPropertyFinder.DataItemPathResovleVisitor;

namespace WinFormsPropertyFinder;


public class DataItemPathResovleVisitor : ElementVisitor<ImmutableList<AutomationElement>>
{
    private readonly ImmutableList<string> path;
    public Queue<string> nameQueue = new();
    private List<AutomationElement> result = new();
    public ImmutableList<AutomationElement> Result => this.result.ToImmutableList();


    public DataItemPathResovleVisitor(IEnumerable<string> path)
    {
        this.path = path.ToImmutableList();
    }

    public void OnWalkStart()
    {
        this.nameQueue = new Queue<string>(this.path);
        this.result = new List<AutomationElement>();
    }


    //======================================================================================================================


    public void VisitRootElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        if(this.nameQueue.TryDequeue(out string? name))
        {
            walk(ele.FindFirstChild(cf => cf.ByName(name)));
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


    private void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        ele.Patterns.Invoke.Pattern.Invoke();
        this.result.Add(ele);
        if(this.nameQueue.TryDequeue(out string? name))
        {
            walk(ele.FindFirstChild(cf => cf.ByName(name)));
        }
    }

    private void VisitOpendCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.result.Add(ele);
        if(this.nameQueue.TryDequeue(out string? name))
        {
            walk(ele.FindFirstChild(cf => cf.ByName(name)));
        }
    }

    private void VisitPropertyElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        this.result.Add(ele);
    }


    //======================================================================================================================


}