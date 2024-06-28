


import 'package:flutter/material.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:gui/presentation/finder/list/empty_list_tile.dart';
import 'package:gui/presentation/finder/list/property_list_tile.dart';

class PropertyList extends StatelessWidget 
{

  final List<Property> list;
  final void Function(Property)? onItemSelected;

  const PropertyList({
    required this.list,
    this.onItemSelected,
    super.key,
  });


  @override
  Widget build(BuildContext context)
  {
    return (
      this.list.length == 0
      ?
        ListView.builder(
          itemCount: 1,
          itemBuilder: (ctx, index) => EmptyListTile(),
        )
      :
        ListView.builder(
          itemCount: this.list.length,
          itemBuilder: (ctx, index) => PropertyListTile(property: this.list[index])
        )
    )
    ;
  }
}