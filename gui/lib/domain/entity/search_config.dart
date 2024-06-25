
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gui/domain/entity/filter_type.dart';
import 'package:gui/domain/entity/property.dart';

part "search_config.freezed.dart";

@freezed
class SearchConfig with _$SearchConfig {

  const factory SearchConfig({
    required String searchText,
    required FilterType filter,
    required List<ProeprtyGetterType> getters,
  }) = _SearchConfig;

}




