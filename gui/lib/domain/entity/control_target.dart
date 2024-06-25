
import 'package:freezed_annotation/freezed_annotation.dart';

part "control_target.freezed.dart";

/** プロパティを読み取る対象 */
@freezed
class ControlTarget with _$ControlTarget {

  const factory ControlTarget({
    required String id,
    required String name,
  }) = _ControlTarget;
  

}




