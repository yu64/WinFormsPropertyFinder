


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';


@immutable
class SearchField extends ConsumerWidget
{
  const SearchField({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final configNotifier = ref.read(currentSearchConfigProvider.notifier);
    final searchText = ref.watch(currentSearchConfigProvider.select((v) => v.searchText));

    return TextField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: configNotifier.setText,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: (
          IconButton(
            icon: const Icon(
              Icons.clear,
              size: 32,
            ),
            onPressed: configNotifier.resetText,
          )
        ),
        
        label: Text("検索文字列"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }



}