


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/provider/state/state.dart';

@immutable
class SearchField extends ConsumerStatefulWidget
{

  const SearchField({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();

}

class _State extends ConsumerState<SearchField>
{
  late final TextEditingController _controller;


  @override
  void initState() 
  {
    super.initState();

    final searchText = super.ref.read(currentSearchConfigProvider.select((v) => v.searchText));
    this._controller = new TextEditingController(text: searchText);
  }

  @override
  void dispose() 
  {
    super.dispose();
    this._controller.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final configNotifier = super.ref.read(currentSearchConfigProvider.notifier);


    return TextField(
      controller: this._controller,
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
            onPressed: () {
              
              //初期化
              configNotifier.resetText();
              this._controller.text = "";
            },
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