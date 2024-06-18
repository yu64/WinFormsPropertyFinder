using System;

namespace WinFormsPropertyFinder
{
    
    public readonly record struct TargetInfo(int ProcessId, string Title);
    public readonly record struct PropertyInfo(string PropertyPath, string Value, string HelpText);
    public readonly record struct FocusInfo(string Hash, bool IsPropertyPane, bool IsDesignerPane);
    public readonly record struct PathInfo(string PropertyName);

}
