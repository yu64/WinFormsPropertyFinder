


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/logger.dart';
import 'package:gui/presentation/provider/search_list.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SearchList extends ConsumerWidget 
{

  const SearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    
    final itemNotifier = ref.read(searchListProvider.notifier);
    final items = ref.watch(searchListProvider);

    return SearchableList<String>.async(
      onPaginate: () async {
        await Future.delayed(const Duration(milliseconds: 1000));
          itemNotifier.addAll([
            "ABCD",
            "BBAA",
            "AABB",
          ]);
      },
      itemBuilder: (String actor) => Text(actor),
      loadingWidget: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          Text('Loading actors...')
        ],
      ),
      errorWidget: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Error while fetching actors')
        ],
      ),
      asyncListCallback: () async {
        await Future.delayed(
          const Duration(
            milliseconds: 10000,
          ),
        );
        return items;
      },
      asyncListFilter: (q, list) {
        return list
            .where((element) => element.startsWith(q))
            .toList();
      },
      emptyWidget: Text("ないよー"),
      onRefresh: () async {},
      onItemSelected: (String item) {},
      secondaryWidget: new TextButton(
        onPressed: () => {

          itemNotifier.addAll([
            "CCCC",
            "ABCD",
            "BCDA",
          ])
        },
        child: Text("押す")
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

    // return SearchableList<String>(
    //   initialList: items,
    //   itemBuilder: (String user) => new Text(user),
    //   filter: (value) => items.where((v) => v.startsWith(value)).toList(),
    //   emptyWidget:  const Text("ないよー"),
    //   onItemSelected: (item) => {},
    //   secondaryWidget: new TextButton(
    //     onPressed: () => {

    //       itemNotifier.addAll([
    //         "CCCC",
    //         "ABCD",
    //         "BCDA",
    //       ])
    //     },
    //     child: Text("押す")
    //   ),
    //   inputDecoration: InputDecoration(
    //     labelText: "Search Actor",
    //     fillColor: Colors.white,
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(
    //         color: Colors.blue,
    //       width: 1.0,
    //       ),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //   ),
    // );
  }
}