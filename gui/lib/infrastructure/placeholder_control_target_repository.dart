

import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/domain/repository/control_target_repository.dart';

class PlaceholderControlTargetRepository implements ControlTargetRepository
{
  @override
  Future<List<ControlTarget>> getAll() async
  {
    await Future.delayed(const Duration(milliseconds: 1000));

    return const [

      ControlTarget(id: "12345", name: "プレースホルダA"),
      ControlTarget(id: "67890", name: "プレースホルダB"),
      ControlTarget(id: "1234", name: "プレースホルダC"),
    ];
  }

}