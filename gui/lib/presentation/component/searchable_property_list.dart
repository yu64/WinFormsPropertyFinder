


import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SearchablePropertyList<T> extends StatelessWidget 
{

  final List<T> list;
  final void Function(T)? onItemSelected;

  const SearchablePropertyList({
    required this.list,
    this.onItemSelected,
    super.key,
  });


  @override
  Widget build(BuildContext context)
  {
    // final asyncItems = ref.watch(propertyListProvider);
    // final items = ref.watch(propertyListProvider.future);

    return SearchableList<T>(
      initialList: this.list,
      itemBuilder: (T value) => Text(value.toString()),
      filter: (value) => this.list.where((v) => v.toString().startsWith(value)).toList(),
      emptyWidget:  const Text("ないよー"),
      onItemSelected: this.onItemSelected,
      secondaryWidget: new TextButton(
        onPressed: () => {},
        child: Text("更新")
      ),
      inputDecoration: InputDecoration(
        labelText: "Search Actor",
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
          width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}