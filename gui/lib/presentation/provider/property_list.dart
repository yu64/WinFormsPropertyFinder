

import 'package:gui/core/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "property_list.g.dart";

@Riverpod(keepAlive: false)
Future<List<String>> propertyList(PropertyListRef ref) async 
{

  await Future.delayed(const Duration(milliseconds: 1000));

  String suffix = DateTime.now().toIso8601String();

  logger.i("プロバイダー評価: $suffix");

  return [

    "フェッチ_01_$suffix",
    "フェッチ_02_$suffix",
    "フェッチ_03_$suffix",

  ];
}