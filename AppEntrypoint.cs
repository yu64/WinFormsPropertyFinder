using System.CommandLine;
using System.CommandLine.Invocation;
using System.CommandLine.NamingConventionBinder;
using System.Reflection.Metadata.Ecma335;
using System.Security.Cryptography;

namespace WinFormsPropertyFinder;

/// <summary>
/// Main関数と同名のクラスを作成できないため、この名称。
/// コンソールにおけるコントローラとしての役割を持つ。
/// </summary>
class AppEntrypoint
{
    public static async Task<int> Main(string[] args)
    {
        //レイヤードアーキテクチャの依存関係を解決する場所

        var usecase = new Usecase();
        var con = new ConsoleController(usecase);

        return await con.InvokeAsync(args);
    }





    

}