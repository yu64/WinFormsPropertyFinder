// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allPropertyHash() => r'df4fb472d63c2025a5a367c8868a89e328deda68';

/// See also [allProperty].
@ProviderFor(allProperty)
final allPropertyProvider = AutoDisposeFutureProvider<List<Property>>.internal(
  allProperty,
  name: r'allPropertyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allPropertyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllPropertyRef = AutoDisposeFutureProviderRef<List<Property>>;
String _$allTargetHash() => r'6153002e95e06fbcc7503c898bc7a2d432a011d2';

/// See also [allTarget].
@ProviderFor(allTarget)
final allTargetProvider =
    AutoDisposeFutureProvider<List<ControlTarget>>.internal(
  allTarget,
  name: r'allTargetProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allTargetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllTargetRef = AutoDisposeFutureProviderRef<List<ControlTarget>>;
String _$currentTargetHash() => r'5ee0cea25c359c615b40f75b6046ac6f79e1f953';
/** 現在の操作対象 */
///
/// Copied from [CurrentTarget].
@ProviderFor(CurrentTarget)
final currentTargetProvider =
    AutoDisposeNotifierProvider<CurrentTarget, ControlTarget?>.internal(
  CurrentTarget.new,
  name: r'currentTargetProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentTargetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentTarget = AutoDisposeNotifier<ControlTarget?>;
String _$currentSearchConfigHash() =>
    r'87e9d0b2129f1caef6607c0ea901172f8e21ff7b';
/** 検索条件 */
///
/// Copied from [CurrentSearchConfig].
@ProviderFor(CurrentSearchConfig)
final currentSearchConfigProvider =
    AutoDisposeNotifierProvider<CurrentSearchConfig, SearchConfig>.internal(
  CurrentSearchConfig.new,
  name: r'currentSearchConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSearchConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSearchConfig = AutoDisposeNotifier<SearchConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
