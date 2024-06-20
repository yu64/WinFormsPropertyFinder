

import 'package:riverpod_annotation/riverpod_annotation.dart';

part "sample_count.g.dart";

@Riverpod(keepAlive: true)
class SampleCount extends _$SampleCount
{

  @override
  int build() => 0;

  
  void add()
  {
    super.state++;
  }
}