


import 'package:flutter/material.dart';
import 'package:gui/domain/entity/property.dart';

@immutable
class PropertyListTile extends StatelessWidget 
{

  final Property property;


  const PropertyListTile({

    required this.property,
    super.key
  });


  @override
  Widget build(BuildContext context)
  {
    return new ListTile(

      title: Text(this.property.path),
    );
  }

}