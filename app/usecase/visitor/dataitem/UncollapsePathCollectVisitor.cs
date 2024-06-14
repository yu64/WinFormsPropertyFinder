using System;
using System.Collections.Immutable;
using FlaUI.Core.AutomationElements;
using FlaUI.Core.Definitions;
using static WinFormsPropertyFinder.UncollapsePathCollectVisitor;

namespace WinFormsPropertyFinder;



public class UncollapsePathCollectVisitor : PathCollectVisitor
{


    public UncollapsePathCollectVisitor(string separator = ".") : base(separator)
    {
        //なし
    }


    //======================================================================================================================


    private protected override void VisitClosedCollapseElement(AutomationElement ele, Action<AutomationElement> walk)
    {
        //閉じていたら何もしない
    }


    //======================================================================================================================


}

