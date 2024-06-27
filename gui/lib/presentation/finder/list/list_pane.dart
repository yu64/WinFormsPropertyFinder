


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:gui/presentation/finder/list/property_list.dart';
import 'package:gui/presentation/shared/loading_overlay.dart';

class ListPane extends ConsumerWidget 
{
  const ListPane({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final filteredProperty = ref.watch(filteredPropertyProvider.future);




    return LoadingOverlay(
      future: filteredProperty,
      initData: const <Property>[],
      loadingWidgetFunc: () => const LinearProgressIndicator(),
      loadedWidgetFunc: (data) => PropertyList(
        list: data
      )
    );
  }





}