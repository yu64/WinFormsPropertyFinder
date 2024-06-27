

import 'dart:convert';

import 'package:gui/core/logger.dart';
import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/domain/repository/control_target_repository.dart';
import 'package:gui/main.dart';
import 'package:process_run/process_run.dart';

class ConsoleControlTargetRepository implements ControlTargetRepository
{
  @override
  Future<List<ControlTarget>> getAll() async
  {
    try
    {
      //シェル実行
      final shell = Shell();
      final result =  await shell.run("""
        ${Env.cuiPath} get target --format json
      """);

      logger.d(result.outText);

      //結果をJSONとしてパース
      List<dynamic> data = jsonDecode(result.outText);
      logger.d(data);


      return data
      .map((v) => v as Map<String, dynamic>)
      .where((v) => 
        v["processId"] != null 
        && v["title"] != null
      )
      .map((v) => 
        ControlTarget(
          id: v["processId"]!.toString(), 
          name: v["title"]!
        )
      )
      .toList();
    }
    catch(e)
    {
      logger.e(e);
    }

    return [];
  }

}