


using FlaUI.Core.AutomationElements;

namespace WinFormsPropertyFinder.cui;


public abstract class AbstractDataItemVisitor<R> : IElementVisitor<R>
{
    public abstract R Result { get; }


    public virtual void OnWalkStart()
    {
        //デフォルトメソッド
    }

    public virtual void OnWalkFinish()
    {
        //デフォルトメソッド
    }

    public abstract void VisitRootElement(AutomationElement ele, Action<AutomationElement> walk);

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

    private protected abstract void VisitOpendCollapseElement(AutomationElement ele, Action<AutomationElement> walk);
    private protected abstract void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk);
    private protected abstract void VisitPropertyElement(AutomationElement ele, Action<AutomationElement> walk);

}