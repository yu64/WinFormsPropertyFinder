



import 'package:gui/domain/repository/control_target_repository.dart';
import 'package:gui/domain/repository/property_repository.dart';
import 'package:gui/infrastructure/placeholder_control_target_repository.dart';
import 'package:gui/infrastructure/placeholder_property_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "repository.g.dart";

@Riverpod(keepAlive: true)
PropertyRepository propertyRepository(PropertyRepositoryRef ref) 
{
  return PlaceholderPropertyRepository();
  //throw Exception("依存性が未解決");
}

@Riverpod(keepAlive: true)
ControlTargetRepository controlTargetRepository(ControlTargetRepositoryRef ref) 
{
  return PlaceholderControlTargetRepository();
  //throw Exception("依存性が未解決");
}