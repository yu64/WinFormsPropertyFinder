

import 'package:gui/core/logger.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "property_list.g.dart";

@Riverpod(keepAlive: false)
Future<List<Property>> propertyList(PropertyListRef ref) async 
{

  await Future.delayed(const Duration(milliseconds: 10000));

  String suffix = DateTime.now().toIso8601String();

  logger.i("プロバイダー評価: $suffix");

  return [

    Property(path: "Path_$suffix", value: "$suffix", helpText: "説明"),
    Property(path: "Path_$suffix", value: "$suffix", helpText: "説明"),
    Property(path: "Path_$suffix", value: "$suffix", helpText: "説明")

  ];
}