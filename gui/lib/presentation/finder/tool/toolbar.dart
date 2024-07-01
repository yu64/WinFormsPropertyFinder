import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';

class Toolbar extends ConsumerWidget
{
  const Toolbar({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    

    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        TextButton.icon(
          label: const Text("更新"), 
          icon: const Icon(Icons.autorenew),
          onPressed: () => ref.invalidate(allPropertyProvider)
        )
      ],
    );
  }
}