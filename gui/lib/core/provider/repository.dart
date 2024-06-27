



import 'package:gui/domain/repository/control_target_repository.dart';
import 'package:gui/domain/repository/property_repository.dart';
import 'package:gui/infrastructure/console_control_target_repository.dart';
import 'package:gui/infrastructure/console_property_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "repository.g.dart";

@Riverpod(keepAlive: true)
PropertyRepository propertyRepository(PropertyRepositoryRef ref) 
{
  return ConsolePropertyRepository();
  //return PlaceholderPropertyRepository();
  //throw Exception("依存性が未解決");
}

@Riverpod(keepAlive: true)
ControlTargetRepository controlTargetRepository(ControlTargetRepositoryRef ref) 
{
  return ConsoleControlTargetRepository();
  //return PlaceholderControlTargetRepository();
  //throw Exception("依存性が未解決");
}