using System;
using FlaUI.Core.AutomationElements;

namespace WinFormsPropertyFinder.cui;

public static class ElementWalker
{
    public static R Walk<R>(
        AutomationElement root,
        IElementVisitor<R> visitor
    )
    {
        void walk(AutomationElement next)
        {
            visitor.VisitOtherElement(next, walk);
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

public interface IElementVisitor<R>
{
    public R Result { get; }

    public virtual void OnWalkStart()
    {
        //デフォルトメソッド
    }

    public virtual void OnWalkFinish()
    {
        //デフォルトメソッド
    }

    public void VisitRootElement(AutomationElement ele, Action<AutomationElement> walk);
    public void VisitOtherElement(AutomationElement ele, Action<AutomationElement> walk);

}

