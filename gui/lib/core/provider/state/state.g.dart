// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allPropertyHash() => r'50f2397c64a9436cd80c51635299bc5ee6bb6b9a';

/// See also [allProperty].
@ProviderFor(allProperty)
final allPropertyProvider = FutureProvider<List<Property>>.internal(
  allProperty,
  name: r'allPropertyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allPropertyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllPropertyRef = FutureProviderRef<List<Property>>;
String _$currentTargetHash() => r'f1a241ccbe8a846b7bb5dc8d5a732c416cfb900c';

/// See also [CurrentTarget].
@ProviderFor(CurrentTarget)
final currentTargetProvider =
    NotifierProvider<CurrentTarget, ControlTarget?>.internal(
  CurrentTarget.new,
  name: r'currentTargetProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentTargetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentTarget = Notifier<ControlTarget?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
