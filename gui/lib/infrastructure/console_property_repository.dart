

import 'dart:convert';

import 'package:gui/core/logger.dart';
import 'package:gui/domain/entity/control_target.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:gui/domain/repository/property_repository.dart';
import 'package:gui/main.dart';
import 'package:process_run/shell.dart';

class ConsolePropertyRepository implements PropertyRepository
{
  @override
  Future<List<Property>> getAll(ControlTarget target) async
  {
    try
    {
      //シェル実行
      final shell = Shell();

      final result =  await shell.run("""
        ${Env.cuiPath} get property --format json ${target.id}
      """);

      logger.d(result.outText);


      //結果をJSONとしてパース
      List<dynamic> data = jsonDecode(result.outText);
      logger.d(data);

      //結果を変換
      return data
      .map((v) => v as Map<String, dynamic>)
      .where((v) => 
        v["propertyPath"] != null 
        && v["value"] != null
        && v["helpText"] != null
      )
      .map((v) => 
        Property(
          path: v["propertyPath"],
          value: v["value"],
          helpText: v["helpText"]
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

  @override
  Future<bool> setFocus(ControlTarget target, Property property) async {

    try
    {
      //シェル実行
      final shell = Shell();

      final result =  await shell.run("""
        ${Env.cuiPath} focus property --format json ${target.id} ${property.path}
      """);

      logger.d(result.outText);


      //結果をJSONとしてパース
      List<dynamic> data = jsonDecode(result.outText);
      logger.d(data);

      //結果を変換
      return true;
    }
    catch(e)
    {
      logger.e(e);
    }
    
    return false;
  }
  
}