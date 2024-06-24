


import 'package:flutter/material.dart';
import 'package:gui/domain/entity/property.dart';
import 'package:gui/presentation/shared/property/property_list_tite.dart';

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
    return ListView.builder(
      itemCount: this.list.length,
      itemBuilder: (ctx, index) => PropertyListTile(property: this.list[index])
    );
  }
}