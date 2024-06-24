
import 'package:freezed_annotation/freezed_annotation.dart';

part "control_target.freezed.dart";

@freezed
class ControlTarget with _$ControlTarget {

  const factory ControlTarget({
    required String id,
    required String name,
  }) = _ControlTarget;
  

}




