
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/presentation/finder/target/target_dropdown.dart';
import 'package:gui/presentation/shared/loading_switcher.dart';




class FinderPage extends ConsumerWidget
{

  const FinderPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final currentTargetNotifier = ref.read(currentTargetProvider.notifier);
    final currentTarget = ref.watch(currentTargetProvider);

    final allTarget = ref.watch(allTargetProvider.future);
    final allProperty = ref.watch(allPropertyProvider.future);

    

    return Scaffold(
      body: Column(
        children: [
          
          
          LoadingSwitcher(
            future: allTarget,
            loadedWidget: (data) => TargetDropdown(
              items: data,
              current: currentTarget,
              onSelected: (value) => currentTargetNotifier.set(value),
            ),
          ),

          
          
          Text("SearchToolBar"),
          Expanded(
            child: Text("PropertyList"),
          )
        ],
      ),
    );


    // return Scaffold(
    //   body: Column(
    //     children: [
    //       TextButton(
    //         onPressed: () => ref.invalidate(allPropertyProvider), 
    //         child: Text("更新") 
    //       ),

    //       SearchField(),

    //       LoadingSwitcher(
    //         future: allProperty,
    //         loadedWidget: (data) => Expanded(
    //           child: PropertyList(
    //             list: data
    //           ),
    //         ),
    //       )

          
    //     ]
    //   )
      
      
      
    // );
  }

}