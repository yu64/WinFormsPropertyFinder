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
                new SubCommand("target", "")
                {
                    CommandHandler.Create(this.GetTarget)
                },

                new SubCommand("property", "")
                {
                    new Argument<string>(
                        "name",
                        "これが名前？"
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



    private void GetTarget()
    {   
        var result = this.usecase.GetTarget();
        result.ForEach(v => System.Console.WriteLine($"{v.Item1}, {v.Item2}"));
    }

    private void GetProperty(string name)
    {
        System.Console.WriteLine(name);
    }

    private void FocusProperty(string target)
    {
        System.Console.WriteLine(target);
    }

    private void FindProperty()
    {
        
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

