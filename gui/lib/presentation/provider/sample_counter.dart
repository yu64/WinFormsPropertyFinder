

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final sampleCounterProvider = StateNotifierProvider<_Notifier, List<String>>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<List<String>> 
{

  _Notifier(): super(["AAAA", "BBBB"]);


  
  void addAll(List<String> list)
  {
    state.addAll(list);
  }
}