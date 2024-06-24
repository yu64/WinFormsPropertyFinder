
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/presentation/shared/loading_switcher.dart';
import 'package:gui/presentation/shared/property/property_list.dart';
import 'package:gui/presentation/shared/search_field.dart';




class FinderPage extends ConsumerWidget
{

  const FinderPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final allProperty = ref.watch(allPropertyProvider.future);


    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () => ref.invalidate(allPropertyProvider), 
            child: Text("更新") 
          ),

          SearchField(),

          LoadingSwitcher(
            future: allProperty,
            loadedWidget: (data) => Expanded(
              child: PropertyList(
                list: data
              ),
            ),
          )

          
        ]
      )
      
      
      
    );
  }

}