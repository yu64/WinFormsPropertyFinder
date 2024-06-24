

import 'package:gui/domain/repository/property_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "property_repository.g.dart";

@Riverpod(keepAlive: true)
Future<PropertyRepository> propertyRepository(PropertyRepositoryRef ref) async 
{
  throw Exception("依存性が未解決");
}