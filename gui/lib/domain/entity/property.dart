
import 'package:freezed_annotation/freezed_annotation.dart';

part "property.freezed.dart";

/** 読み取られたプロパティ */
@freezed
class Property with _$Property {

  const factory Property({
    required String path,
    required String value,
    required String helpText,
  }) = _Property;
  
}



/** プロパティの検索可能な項目に対応する列挙型 */
enum ProeprtyGetterType {

  path(name: "パス"),
  propertyName(name: "項目名"),
  value(name: "値"),
  helpText(name: "説明"),

  ;

  final String name;

  const ProeprtyGetterType({
    required this.name
  });

}


extension ProeprtyGetterTypeExt on ProeprtyGetterType {

  String getValue(Property p)
  {
    switch(this)
    {
      case ProeprtyGetterType.path:
        return p.path;
      case ProeprtyGetterType.propertyName:
        return p.path.split(".").last;
      case ProeprtyGetterType.value:
        return p.value;
      case ProeprtyGetterType.helpText:
        return p.helpText;
    }
  }
}


