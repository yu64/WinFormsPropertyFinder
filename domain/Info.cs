using System;

namespace WinFormsPropertyFinder.domain
{
    public record TargetInfo(int ProcessId, string Title);
    public record PropertyInfo(string PropertyPath, string Value, string HelpText);


}
