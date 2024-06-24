

import 'package:gui/core/logger.dart';
import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:gui/domain/repository/property_repository.dart';

class PlaceholderPropertyRepository implements PropertyRepository
{
  @override
  Future<List<Property>> getAll(ControlTarget target) async
  {
    await Future.delayed(const Duration(milliseconds: 10000));
    String suffix = DateTime.now().toIso8601String();

    return [
      Property(path: "PlaceHolder.$suffix", value: "true", helpText: "真偽値"),
      Property(path: "PlaceHolder.$suffix", value: "0", helpText: "値"),
      Property(path: "PlaceHolder.$suffix", value: "text", helpText: "テキスト")
    ];
  }

  @override
  Future<bool> setFocus(ControlTarget target, Property property) async {

    logger.i("フォーカスを合わせます。${target.name}/${property.path}");
    return true;
  }
  
}