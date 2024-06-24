

import 'package:gui/domain/entity/control_target.dart';

abstract interface class ControlTargetRepository 
{
  Future<List<ControlTarget>> getAll();
}