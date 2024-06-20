

import 'package:riverpod_annotation/riverpod_annotation.dart';

part "search_list.g.dart";

@Riverpod(keepAlive: true)
class SearchList extends _$SearchList
{

  @override
  List<String> build() => ["AAAA", "BBBB"];

  
  void addAll(List<String> list)
  {
    state.addAll(list);
  }
}