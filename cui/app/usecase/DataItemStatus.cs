using System;
using FlaUI.Core.AutomationElements;

namespace WinFormsPropertyFinder;


public enum DataItemStatus 
{

    Open,
    Close,
    NoSupport
    
}


public static class DataItemStatusHelper
{
    public static DataItemStatus GetDataItemStatus(AutomationElement ele)
    {
        string? action = ele.Patterns.LegacyIAccessible.PatternOrDefault?.DefaultAction;
        if(string.IsNullOrEmpty(action))
        {
            return DataItemStatus.NoSupport;
        }

        return (string.Equals(action, "展開") ? DataItemStatus.Close : DataItemStatus.Open);
    }
}



