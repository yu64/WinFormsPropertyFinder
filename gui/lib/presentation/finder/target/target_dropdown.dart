


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/domain/entity/control_target.dart';

class TargetDropdown extends ConsumerWidget
{
  final List<ControlTarget> items;
  final ControlTarget? current;
  final void Function(ControlTarget?)? onSelected;


  const TargetDropdown({
    required this.items,
    this.current,
    this.onSelected,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: LayoutBuilder(
        builder: (ctx, con) => DropdownMenu<ControlTarget>(
          dropdownMenuEntries: this.items.map((v) => DropdownMenuEntry<ControlTarget>(
            value: v, 
            label: v.name
          )).toList(),

          initialSelection: this.current,
          label: const Text("Visual Studio"),

          onSelected: this.onSelected,

          width: con.maxWidth,

          enableFilter: false,
          requestFocusOnTap: true,
          enableSearch: true,

        )
      )
    )
    ;
  }
}