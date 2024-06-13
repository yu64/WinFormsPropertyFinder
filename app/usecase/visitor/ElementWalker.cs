using System;
using FlaUI.Core.AutomationElements;

namespace WinFormsPropertyFinder;

public static class ElementWalker
{
    public static R Walk<R>(
        AutomationElement root,
        ElementVisitor<R> visitor
    )
    {
        void walk(AutomationElement next)
        {

            var status = DataItemStatusHelper.GetDataItemStatus(next);
            if (status == DataItemStatus.Open)
            {
                visitor.VisitOpendCollapseElement(next, walk);
                return;
            }

            if (status == DataItemStatus.Close)
            {
                visitor.VisitClosedCollapseElement(next, walk);
                return;
            }

            visitor.VisitPropertyElement(next, walk);
        }

        try
        {
            visitor.OnWalkStart();
            visitor.VisitRootElement(root, walk);
            return visitor.Result;    
        }
        finally
        {
            visitor.OnWalkFinish();
        }
    }
}

public interface ElementVisitor<R>
{
    public R Result { get; }

    public void OnWalkStart()
    {
        //デフォルトメソッド
    }

    public void OnWalkFinish()
    {
        //デフォルトメソッド
    }

    public void VisitRootElement(AutomationElement ele, Action<AutomationElement> walk);
    public void VisitOpendCollapseElement(AutomationElement ele, Action<AutomationElement> walk);
    public void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk);
    public void VisitPropertyElement(AutomationElement ele, Action<AutomationElement> walk);

}

