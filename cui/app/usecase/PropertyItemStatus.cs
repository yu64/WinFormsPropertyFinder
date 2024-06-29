using System;
using FlaUI.Core.AutomationElements;

namespace WinFormsPropertyFinder.cui;


public enum PropertyItemStatus 
{

    Open,
    Close,
    NoSupport
    
}


public static class PropertyItemStatusHelper
{
    public static PropertyItemStatus GetDataItemStatus(AutomationElement ele)
    {
        string? action = ele.Patterns.LegacyIAccessible.PatternOrDefault?.DefaultAction;
        if(string.IsNullOrEmpty(action))
        {
            return PropertyItemStatus.NoSupport;
        }

        return (string.Equals(action, "展開") ? PropertyItemStatus.Close : PropertyItemStatus.Open);
    }
}



