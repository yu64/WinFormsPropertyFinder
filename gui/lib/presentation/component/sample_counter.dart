



import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SampleCounter extends ConsumerWidget
{
  const SampleCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) 
  {
    return new Row(
      children: [
        new Text(""),
        new TextButton(
          onPressed: () => {

          }, 
          child: Text("押す")
        )
      ],
    );
  }
  
}