using System.CommandLine;
using System.Security.Cryptography;
using WinFormsPropertyFinder.action;

namespace WinFormsPropertyFinder;

/// <summary>
/// Main関数と同名のクラスを作成できないため、この名称。
/// </summary>
class AppEntrypoint
{
    public static async Task<int> Main(string[] args)
    {
        RootCommand cmd = new()
        {
            Description = "Visual Studioの WinFormsプロパティペインからプロパティを検索します"
        };

        cmd.AddCommand(AppEntrypoint.CreateProcessCommand());
        

        return await cmd.InvokeAsync(args);
    }


    private static Command CreateProcessCommand()
    {
        Command cmd = new Command("process", "");

        Option<string> configFileOption = new Option<string>(
            aliases: new string[] {"--list", "-l"},
            description: "プロセスリスト"
        );

        cmd.AddOption(configFileOption);

        cmd.SetHandler<string>(ProcessListDetector.GetProcessList, configFileOption);

        return cmd;
    }



}