


import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/domain/entity/property.dart';

abstract class PropertyRepository 
{
  Future<List<Property>> getAll(ControlTarget target);
  Future<bool> setFocus(ControlTarget target, Property property);

}

abstract class ControlTargetRepository 
{
  Future<List<ControlTarget>> getAll();
}