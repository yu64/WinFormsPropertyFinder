


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:collection/collection.dart';

@immutable
class PropertyListTile extends ConsumerWidget 
{

  final Property property;


  const PropertyListTile({

    required this.property,
    super.key
  });


  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    //アプリケーション内の値を呼び出す
    final theme = Theme.of(context);

    final getters = ref.watch(currentSearchConfigProvider.select((v) => v.getters));
    final setFocus = ref.watch(setFocusProvider);


    //最初のGetterを求める
    final sortedGetters = getters.sorted((a, b) => a.index - b.index);
    final firstGetter = sortedGetters.firstOrNull ?? ProeprtyGetterType.path;

    //補足が必要が確認する
    final useSubtitle = (ProeprtyGetterType.path != firstGetter);

    //Getterと対応するアイコンを定義する
    final icons = { 

      ProeprtyGetterType.path: Icons.category,
      ProeprtyGetterType.propertyName: Icons.label,
      ProeprtyGetterType.value: Icons.data_object,
      ProeprtyGetterType.helpText: Icons.subject,

    };

    //表示する文字列を組み立てる
    final title = "${firstGetter.name}: ${firstGetter.getValue(this.property)}";
    final subtitle = this.property.path;

    final fullText = ProeprtyGetterType.values
    .map((t) => "${t.name}: ${t.getValue(this.property)}")
    .join("\n");


    return ListTile(

      onTap: () async => setFocus(this.property),

      //最初のアイコン
      leading: Tooltip(
        message: fullText,
        triggerMode: TooltipTriggerMode.longPress,
        child: Icon(icons[firstGetter]),
      ),

      //タイトル文字列
      title: Text(
        title,
        style: theme.textTheme.titleSmall,
      ),
      
      //補足
      subtitle: (
        useSubtitle 
        ? Text(
            subtitle,
            style: theme.textTheme.labelSmall,
          ) 
        : null
      ),

    )
    ;
  }

}