


enum FilterType
{
  plain(name: "プレーンテキスト"),
  regex(name: "正規表現"),

  ;

  final String name;

  const FilterType({
    required this.name
  });

}


extension FilterTypeExt on FilterType 
{

  bool Function(String srcText, String partText) get filterFunc
  {
    switch (this) 
    {
      case FilterType.plain:
        return (src, part) => src.toLowerCase().contains(part.toLowerCase());
      case FilterType.regex:
        return (src, part) => RegExp(part).hasMatch(src);
    }
  }
}