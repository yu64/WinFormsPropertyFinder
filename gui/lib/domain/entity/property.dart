
import 'package:freezed_annotation/freezed_annotation.dart';

part "property.freezed.dart";

@freezed
class Property with _$Property {

  const factory Property({
    required String path,
    required String value,
    required String helpText,
  }) = _Property;
  

}




