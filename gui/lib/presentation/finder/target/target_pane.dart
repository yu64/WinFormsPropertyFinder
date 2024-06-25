import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';
import 'package:gui/presentation/finder/target/target_dropdown.dart';
import 'package:gui/presentation/shared/loading_switcher.dart';

class TargetPane extends ConsumerWidget
{
  const TargetPane({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final currentTargetNotifier = ref.read(currentTargetProvider.notifier);
    final currentTarget = ref.watch(currentTargetProvider);

    final allTarget = ref.watch(allTargetProvider.future);

    return LoadingSwitcher(
      future: allTarget,
      loadedWidget: (data) => TargetDropdown(
        items: data,
        current: currentTarget,
        onSelected: (value) => currentTargetNotifier.set(value),
      ),
    );
  }
}