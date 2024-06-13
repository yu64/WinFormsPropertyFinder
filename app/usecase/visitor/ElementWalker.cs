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
    public void VisitOtherElement(AutomationElement ele, Action<AutomationElement> walk);

}

