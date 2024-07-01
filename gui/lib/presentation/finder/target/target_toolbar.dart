import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';

class TargetToolbar extends ConsumerWidget
{
  const TargetToolbar({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    

    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          label: const Text("更新"), 
          icon: const Icon(Icons.autorenew),
          onPressed: () => ref.invalidate(allTargetProvider)
        ),
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => showLicensePage(context: context),
        )
      ],
    );
  }
}