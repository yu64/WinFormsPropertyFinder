


import 'package:flutter/material.dart';

typedef Level = (bool Function(int), Widget Function(int));

@immutable
class ColumnWithLevel<F> extends StatelessWidget 
{
  final List<Level> levelList;
  final Widget Function(int) emptyWidget; 

  const ColumnWithLevel({
    required this.emptyWidget,
    required this.levelList,
    super.key
  });
  

  @override
  Widget build(BuildContext context)
  {
    return this._buildLevel(context, 0).$1;
  }

  (Widget, bool) _buildLevel(BuildContext context, int levelIndex)
  {
    //末端
    if( !(levelIndex < levelList.length) )
    {
      return (this.emptyWidget(levelIndex), true);
    }

    final level = this.levelList[levelIndex];

    //非表示
    if(!level.$1(levelIndex))
    {
      return (this.emptyWidget(levelIndex), true);
    }

    final children = [level.$2(levelIndex)];

    final nextLevel = this._buildLevel(context, levelIndex + 1);
    if(!nextLevel.$2)
    {
      children.add(nextLevel.$1);
    }


    //表示
    return (
      
      Column(
        children: children,
      ),
      false
    );
  }


}