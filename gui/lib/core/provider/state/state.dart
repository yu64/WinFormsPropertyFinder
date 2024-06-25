
import 'package:gui/core/provider/repository.dart';
import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "state.g.dart";

@Riverpod(keepAlive: true)
Future<List<Property>> allProperty(AllPropertyRef ref) async 
{
  final repo = ref.watch(propertyRepositoryProvider);
  final target = ref.watch(currentTargetProvider);

  return target == null ? repo.getAll(target!) : [];
}

@Riverpod(keepAlive: true)
Future<List<ControlTarget>> allTarget(AllTargetRef ref) async 
{
  final repo = ref.watch(controlTargetRepositoryProvider);

  return repo.getAll();
}

@Riverpod(keepAlive: true)
class CurrentTarget extends _$CurrentTarget
{
  @override 
  ControlTarget? build() => null;

  void set(ControlTarget? target)
  {
    super.state = target;
  }

  void delete()
  {
    super.state = null;
  }

}