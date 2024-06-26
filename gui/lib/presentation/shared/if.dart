


import 'package:flutter/material.dart';

@immutable
class If extends StatelessWidget 
{
  final bool Function() flagFunc;
  final Widget child;
  final Widget? elseChild;

  const If({

    required this.flagFunc,
    required this.child,
    this.elseChild,
    super.key
  });
  


  @override
  Widget build(BuildContext context)
  {
    return (
      this.flagFunc()
      ?
      this.child
      :
      this.elseChild ?? const Spacer()
    );
  }

}