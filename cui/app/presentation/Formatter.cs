

using System.Collections.Immutable;
using System.Globalization;
using System.Text;
using System.Text.Encodings.Web;
using System.Text.Json;
using CsvHelper;

namespace WinFormsPropertyFinder.cui;



public enum FormatterType
{
    CSV,
    JSON
}

public static class FormatterTypeExt
{
    public static string Format<R>(this FormatterType type, ImmutableList<R> list)
    {
        //JSON形式で出力
        if(type == FormatterType.JSON)
        {
            return JsonSerializer.Serialize(list, new JsonSerializerOptions()
            {
                // JavaScriptEncoder.Createでエンコードしない文字を指定するのも可
                Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping, 
                // 読みやすいようインデントを付ける
                WriteIndented = true,
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            });
        }


        //CSV形式で出力

        var config = new CsvHelper.Configuration.CsvConfiguration(CultureInfo.InvariantCulture)
        {
            ShouldQuote = (field) => true,
            Delimiter = ", "
        };

        var sb = new StringBuilder();
        using var writer = new StringWriter(sb);
        using var csvWriter = new CsvWriter(writer, config);
        csvWriter.WriteRecords(list);

        return sb.ToString();
    }
}