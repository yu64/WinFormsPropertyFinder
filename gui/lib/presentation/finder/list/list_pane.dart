


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/presentation/finder/list/property_list.dart';
import 'package:gui/presentation/shared/loading_switcher.dart';

class ListPane extends ConsumerWidget 
{
  const ListPane({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final filteredProperty = ref.watch(filteredPropertyProvider.future);

    return LoadingSwitcher(
      future: filteredProperty,
      loadedWidget: (data) => Expanded(
        child: new PropertyList(
          list: data
        )
      )
    );
  }





}