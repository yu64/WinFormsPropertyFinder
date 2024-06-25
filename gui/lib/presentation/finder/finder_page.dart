
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/domain/entity/control_target.dart';
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
    final currentTargetNotifier = ref.read(currentTargetProvider.notifier);
    final currentTarget = ref.watch(currentTargetProvider);

    final allTarget = ref.watch(allTargetProvider.future);
    final allProperty = ref.watch(allPropertyProvider.future);

    return Scaffold(
      body: Column(
        children: [

          const TargetPane(),

          If(
            flagFunc: () => (currentTarget != null),
            child: const ToolPane(),
          )
        ]
      )
    );

  }

}