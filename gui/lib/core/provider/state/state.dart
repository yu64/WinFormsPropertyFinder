
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

  return target != null ? repo.getAll(target) : [];
}


@Riverpod(keepAlive: false)
Future<List<ControlTarget>> allTarget(AllTargetRef ref) async 
{
  final repo = ref.watch(controlTargetRepositoryProvider);

  return repo.getAll();
}


@Riverpod(keepAlive: false)
Future<List<Property>> filteredProperty(FilteredPropertyRef ref) async 
{
  final allProperty = await ref.watch(allPropertyProvider.future);
  final config = ref.watch(currentSearchConfigProvider);
  
  final getters = config.getters;
  final filter = config.filter;
  final searchText = config.searchText;

  //プロパティごとにフィルタリング
  return allProperty.where((p) {

    //ゲッターごとにループ
    for(final getter in getters)
    {
      //プロパティの値が、検索条件に一致するか確認する
      if(filter.filterFunc(getter.getValue(p), searchText))
      {
        return true;
      }

      //一致しないなら次のゲッターに進む
    }

    // getters
    // .map((getter) => filter.filterFunc(getter.getValue(p), searchText))
    // .any((b) => b);

    //全て一致しない場合
    return false;
  }).toList();
}


@Riverpod(keepAlive: false)
Future<bool> Function(Property) setFocus(SetFocusRef ref) 
{
  final target = ref.watch(currentTargetProvider);
  final repo = ref.watch(propertyRepositoryProvider);

  return (p) async => target != null ? repo.setFocus(target, p) : false;
}





/** 現在の操作対象 */
@Riverpod(keepAlive: false)
class CurrentTarget extends _$CurrentTarget
{
  @override 
  ControlTarget? build() 
  {
    _fetch();
    return null;
  }

  //初期化時に、操作対象のリストを読み込む。一つだけの場合、それを対象とする
  void _fetch() async 
  {
    final allTarget = await this.ref.watch(allTargetProvider.future);
    if(allTarget.length == 1)
    {
      this.set(allTarget[0]);
    }
  }

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

  void resetText()
  {
    super.state = super.state.copyWith(searchText: ""); 
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