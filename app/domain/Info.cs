using System;

namespace WinFormsPropertyFinder
{
    
    public readonly record struct TargetInfo(int ProcessId, string Title);
    public readonly record struct PropertyInfo(string PropertyPath, string Value, string HelpText);


}
