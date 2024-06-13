using System;
using System.CommandLine;
using System.CommandLine.Invocation;
using System.CommandLine.NamingConventionBinder;
using System.Data;
using System.Runtime.Serialization;
using System.Text.Json;

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


    /// <summary>
    /// コマンド定義
    /// </summary>
    private RootCommand DefineCommand()
    {
        //共通引数
        Argument<int> targetArgument = new Argument<int>(
            "target",
            "対象となるVisual StudioのプロセスID"
        );

        //共通オプション
        Option<FormatterType> canOutputJsonOption = new Option<FormatterType>(
            aliases: new string[] {"--format"}, 
            description: "出力形式",
            getDefaultValue: () => FormatterType.CSV
        );

        //コマンド体系を定義
        return new()
        {
            new SubCommand("get", "取得")
            {
                new SubCommand("target", "対象となるVisualStudioのプロセスID一覧を表示する")
                {
                    canOutputJsonOption,

                    CommandHandler.Create(this.GetTarget)
                },

                new SubCommand("property", "対象のプロパティ一覧を表示する")
                {
                    targetArgument,
                    canOutputJsonOption,

                    CommandHandler.Create(this.GetProperty)
                },
            },

            new SubCommand("focus", "フォーカス移動")
            {
                new SubCommand("property", "")
                {
                    CommandHandler.Create(this.FocusProperty)
                },
            },

            new SubCommand("find", "検索")
            {
                new SubCommand("property", "")
                {
                    CommandHandler.Create(this.FindProperty)
                },
            },
        };
    }



//=====================================================================================================

    
    private int GetTarget(FormatterType format)
    {   
        return ExceptionUtil.TryCatch(0, 1, () => {

            var result = this.usecase.GetTarget();
            Console.WriteLine(format.Format(result));
        });
    }

    private int GetProperty(int target, FormatterType format)
    {
        return ExceptionUtil.TryCatch(0, 1, () => {

            var result = this.usecase.GetProperty(target);
            Console.WriteLine(format.Format(result));
        });
    }

    private int FocusProperty()
    {
        return ExceptionUtil.TryCatch(0, 1, () => {

        });
    }

    private int FindProperty()
    {
        return ExceptionUtil.TryCatch(0, 1, () => {

        });
    }



//=====================================================================================================







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

