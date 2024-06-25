// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchConfig {
  String get searchText => throw _privateConstructorUsedError;
  FilterType get filter => throw _privateConstructorUsedError;
  List<ProeprtyGetterType> get getters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchConfigCopyWith<SearchConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchConfigCopyWith<$Res> {
  factory $SearchConfigCopyWith(
          SearchConfig value, $Res Function(SearchConfig) then) =
      _$SearchConfigCopyWithImpl<$Res, SearchConfig>;
  @useResult
  $Res call(
      {String searchText, FilterType filter, List<ProeprtyGetterType> getters});
}

/// @nodoc
class _$SearchConfigCopyWithImpl<$Res, $Val extends SearchConfig>
    implements $SearchConfigCopyWith<$Res> {
  _$SearchConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchText = null,
    Object? filter = null,
    Object? getters = null,
  }) {
    return _then(_value.copyWith(
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FilterType,
      getters: null == getters
          ? _value.getters
          : getters // ignore: cast_nullable_to_non_nullable
              as List<ProeprtyGetterType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchConfigImplCopyWith<$Res>
    implements $SearchConfigCopyWith<$Res> {
  factory _$$SearchConfigImplCopyWith(
          _$SearchConfigImpl value, $Res Function(_$SearchConfigImpl) then) =
      __$$SearchConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String searchText, FilterType filter, List<ProeprtyGetterType> getters});
}

/// @nodoc
class __$$SearchConfigImplCopyWithImpl<$Res>
    extends _$SearchConfigCopyWithImpl<$Res, _$SearchConfigImpl>
    implements _$$SearchConfigImplCopyWith<$Res> {
  __$$SearchConfigImplCopyWithImpl(
      _$SearchConfigImpl _value, $Res Function(_$SearchConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchText = null,
    Object? filter = null,
    Object? getters = null,
  }) {
    return _then(_$SearchConfigImpl(
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FilterType,
      getters: null == getters
          ? _value._getters
          : getters // ignore: cast_nullable_to_non_nullable
              as List<ProeprtyGetterType>,
    ));
  }
}

/// @nodoc

class _$SearchConfigImpl implements _SearchConfig {
  const _$SearchConfigImpl(
      {required this.searchText,
      required this.filter,
      required final List<ProeprtyGetterType> getters})
      : _getters = getters;

  @override
  final String searchText;
  @override
  final FilterType filter;
  final List<ProeprtyGetterType> _getters;
  @override
  List<ProeprtyGetterType> get getters {
    if (_getters is EqualUnmodifiableListView) return _getters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_getters);
  }

  @override
  String toString() {
    return 'SearchConfig(searchText: $searchText, filter: $filter, getters: $getters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchConfigImpl &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            const DeepCollectionEquality().equals(other._getters, _getters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchText, filter,
      const DeepCollectionEquality().hash(_getters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchConfigImplCopyWith<_$SearchConfigImpl> get copyWith =>
      __$$SearchConfigImplCopyWithImpl<_$SearchConfigImpl>(this, _$identity);
}

abstract class _SearchConfig implements SearchConfig {
  const factory _SearchConfig(
      {required final String searchText,
      required final FilterType filter,
      required final List<ProeprtyGetterType> getters}) = _$SearchConfigImpl;

  @override
  String get searchText;
  @override
  FilterType get filter;
  @override
  List<ProeprtyGetterType> get getters;
  @override
  @JsonKey(ignore: true)
  _$$SearchConfigImplCopyWith<_$SearchConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
