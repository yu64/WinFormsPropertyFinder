
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/presentation/finder/list/list_pane.dart';
import 'package:gui/presentation/finder/target/target_pane.dart';
import 'package:gui/presentation/finder/tool/tool_pane.dart';
import 'package:gui/presentation/shared/if.dart';




class FinderPage extends ConsumerWidget
{

  const FinderPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final currentTarget = ref.watch(currentTargetProvider);


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            
            const TargetPane(),
            
            Expanded(
              child: If(
                flagFunc: () => (currentTarget != null),
                child: const Column(
                  children: [
                    
                    Divider(),

                    ToolPane(),

                    Expanded(
                      child: ListPane()
                    )
                    ,
                  ],
                ),
              ),
            )
            
          ]
        )
      )
    );

  }

}