

import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/domain/repository/control_target_repository.dart';

class PlaceholderControlTargetRepository implements ControlTargetRepository
{
  @override
  Future<List<ControlTarget>> getAll() async
  {
    await Future.delayed(const Duration(milliseconds: 1000));

    return const [

      ControlTarget(id: "1234", name: "プレースホルダA"),
      ControlTarget(id: "5678", name: "プレースホルダB"),
      ControlTarget(id: "9012", name: "プレースホルダC"),
    ];
  }

}