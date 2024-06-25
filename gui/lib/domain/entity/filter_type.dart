

import 'package:gui/domain/entity/property.dart';

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

  bool Function(String, Property) get filterFunc
  {
    switch (this) 
    {
      case FilterType.plain:
        return (s, p) => p.path.contains(s);
      case FilterType.regex:
        return (s, p) => RegExp(s).hasMatch(p.path);
    }
  }
}