import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/domain/entity/filter_type.dart';
import 'package:gui/domain/entity/property.dart';


class AdvancedSearch extends ConsumerWidget
{

  const AdvancedSearch({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ExpansionTile(
        title: Text(
          "高度な検索条件", 
          style: theme.textTheme.titleSmall, 
        ),
        children: [
          
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "検索文字列", 
              style: theme.textTheme.titleSmall, 
            ),
          ),
          this._buildFilterRadio(context, ref),
          
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "検索対象(OR)", 
              style: theme.textTheme.titleSmall, 
            ),
          ),
          this._buildGetterCheckBox(context, ref)
        ],
      )
    )
    ;
  }


  Widget _buildFilterRadio(BuildContext context, WidgetRef ref)
  {
    final configNotifier = ref.read(currentSearchConfigProvider.notifier);
    final currentFilterType = ref.watch(currentSearchConfigProvider.select((v) => v.filter));

    return Row(
      children: FilterType.values.map((v) => RadioMenuButton(
        value: v, 
        groupValue: currentFilterType, 
        onChanged: configNotifier.setFilterType, 
        child: Text(v.name),
      )).toList(),
    )
    ;
  }


  Widget _buildGetterCheckBox(BuildContext context, WidgetRef ref)
  {
    final configNotifier = ref.read(currentSearchConfigProvider.notifier);
    final getters = ref.watch(currentSearchConfigProvider.select((v) => v.getters));


    void select(bool? isChecked, ProeprtyGetterType getter)
    {
      if(isChecked == null)
      {
        return;
      }

      if(isChecked)
      {
        configNotifier.addGetter(getter);
        return;
      }

      configNotifier.removeGetter(getter);
    }


    return Row(
      children: ProeprtyGetterType.values.map((v) => CheckboxMenuButton(
        value: getters.contains(v), 
        onChanged: (value) => select(value, v), 
        child: Text(v.name)
      )).toList()
    );
  }

}