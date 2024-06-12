using System;
using System.CommandLine;
using System.CommandLine.Invocation;
using System.CommandLine.NamingConventionBinder;
using System.Data;

namespace WinFormsPropertyFinder;


public class ConsoleController
{   
    private readonly Usecase usecase;
    private readonly RootCommand root;
    
    public ConsoleController(Usecase usecase)
    {
        this.usecase = usecase;
        this.root = this.DefineCommand();
    }

    public async Task<int> InvokeAsync(string[] args)
    {
        return await this.root.InvokeAsync(args);
    }


//=====================================================================================================


    private RootCommand DefineCommand()
    {
        //コマンド体系を定義
        return new()
        {
            new SubCommand("get", "一覧取得")
            {
                new SubCommand("target", "対象となるVisualStudioのプロセスID一覧を表示する")
                {
                    CommandHandler.Create(this.GetTarget)
                },

                new SubCommand("property", "対象のプロパティ一覧を表示する")
                {
                    new Argument<int>(
                        "target",
                        "対象となるVisual StudioのプロセスID"
                    ),
                    
                    CommandHandler.Create(this.GetProperty)
                },
            },

            new SubCommand("focus", "フォーカス移動")
            {
                new SubCommand("property", "")
                {
                    new Option<string>(
                        aliases: new string[] {"--target"}, 
                        description: "ターゲット"
                    ),

                    CommandHandler.Create(this.FocusProperty)
                },
            },

            new SubCommand("find", "検索")
            {
                new SubCommand("property", "")
                {
                    new Option<string>(
                        aliases: new string[] {"--target"}, 
                        description: ""
                    ),

                    new Option<string>(
                        aliases: new string[] {"--property"}, 
                        description: ""
                    ),

                    CommandHandler.Create(this.FindProperty)
                },
            },
        };
    }


//=====================================================================================================

    

    private int GetTarget()
    {   
        var result = this.usecase.GetTarget();
        result.ForEach(v => Console.WriteLine($"{v.ProcessId}, {v.Title}"));

        return 0;
    }

    private int GetProperty(int target)
    {
        var result = this.usecase.GetProperty(target);
        result.ForEach(v => Console.WriteLine($"{v.PropertyPath}, {v.Value}, {v.HelpText}"));

        return 0;
    }

    private int FocusProperty(string target)
    {
        System.Console.WriteLine(target);
        return 0;
    }

    private int FindProperty()
    {
        return 0;
    }





//=====================================================================================================


    /// <summary>
    /// ハンドラーを追加する Addメソッドを追加したもの
    /// </summary>
    private class SubCommand : Command
    {
        public SubCommand(string name, string? description = null) : base(name, description)
        {
            
        }

        public void Add(ICommandHandler handler)
        {
            this.Handler = handler;
        }
    }


//=====================================================================================================


}

