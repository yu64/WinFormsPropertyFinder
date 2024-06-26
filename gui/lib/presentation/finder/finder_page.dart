
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/presentation/finder/list/list_pane.dart';
import 'package:gui/presentation/finder/target/target_dropdown.dart';
import 'package:gui/presentation/finder/target/target_pane.dart';
import 'package:gui/presentation/finder/tool/tool_pane.dart';
import 'package:gui/presentation/shared/column_with_level.dart';
import 'package:gui/presentation/shared/if.dart';
import 'package:gui/presentation/shared/loading_switcher.dart';
import 'package:nil/nil.dart';




class FinderPage extends ConsumerWidget
{

  const FinderPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final currentTarget = ref.watch(currentTargetProvider);


    return Scaffold(
      body: Column(
        children: [

          const TargetPane(),

          If(
            flagFunc: () => (currentTarget != null),
            child: const ToolPane(),
            elseChild: Text("ないよー1"),
          ),

          If(
            flagFunc: () => (currentTarget != null),
            child: const ListPane(),
            elseChild: Text("ないよー2"),
          )
          
        ]
      )
    );

  }

}