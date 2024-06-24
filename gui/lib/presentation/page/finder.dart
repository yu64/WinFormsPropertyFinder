
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/presentation/component/loading/loading_switcher.dart';
import 'package:gui/presentation/component/property/property_list.dart';
import 'package:gui/presentation/component/search/search_field.dart';
import 'package:gui/presentation/provider/property_list.dart';




class FinderPage extends ConsumerWidget
{

  const FinderPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final list = ref.watch(propertyListProvider.future);


    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () => ref.invalidate(propertyListProvider), 
            child: Text("更新") 
          ),

          SearchField(),

          LoadingSwitcher(
            future: list,
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