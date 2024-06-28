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
      alignment: MainAxisAlignment.start,
      children: [
        TextButton.icon(
          label: Text("更新"), 
          icon: Icon(Icons.autorenew),
          onPressed: () => ref.invalidate(allTargetProvider)
        )
      ],
    );
  }
}