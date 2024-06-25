
import 'package:gui/core/provider/repository.dart';
import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/domain/entity/filter_type.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:gui/domain/entity/search_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "state.g.dart";

@Riverpod(keepAlive: false)
Future<List<Property>> allProperty(AllPropertyRef ref) async 
{
  final repo = ref.watch(propertyRepositoryProvider);
  final target = ref.watch(currentTargetProvider);

  return target == null ? repo.getAll(target!) : [];
}


@Riverpod(keepAlive: false)
Future<List<ControlTarget>> allTarget(AllTargetRef ref) async 
{
  final repo = ref.watch(controlTargetRepositoryProvider);

  return repo.getAll();
}


/** 現在の操作対象 */
@Riverpod(keepAlive: false)
class CurrentTarget extends _$CurrentTarget
{
  @override 
  ControlTarget? build() => null;

  void set(ControlTarget? value)
  {
    super.state = value;
  }

  void delete()
  {
    super.state = null;
  }

}



/** 検索条件 */
@Riverpod(keepAlive: false)
class CurrentSearchConfig extends _$CurrentSearchConfig
{
  @override 
  SearchConfig build() {

    return this._createInit();
  }

  SearchConfig _createInit()
  {
    return const SearchConfig(
      searchText: "",
      filter: FilterType.plain,
      getters: [ProeprtyGetterType.path]
    );
  }

  void reset()
  {
    super.state = this._createInit();
  }

  void setText(String? text)
  {
    super.state = super.state.copyWith(searchText: text ?? ""); 
  }

  void setFilterType(FilterType? type)
  {
    super.state = super.state.copyWith(filter: type ?? FilterType.plain);
  }

  void addGetter(ProeprtyGetterType getter)
  {
    final newList = [...super.state.getters, getter];
    super.state = super.state.copyWith(getters: newList);
  }

  void removeGetter(ProeprtyGetterType getter)
  {
    final newList = super.state.getters.where((v) => v != getter).toList();
    super.state = super.state.copyWith(getters: newList);
  }


}