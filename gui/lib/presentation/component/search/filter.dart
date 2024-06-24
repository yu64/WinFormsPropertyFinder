


import 'package:flutter/material.dart';

@immutable
class Filter<F> extends StatelessWidget 
{
  final List<F> list;
  final List<F> Function(List<F>)? filter;
  final Widget Function(List<F>) child;


  const Filter({

    required this.list,
    this.filter,
    required this.child,
    super.key
  });
  


  @override
  Widget build(BuildContext context)
  {
    return this.child(this.filter?.call(this.list) ?? this.list);
  }

}