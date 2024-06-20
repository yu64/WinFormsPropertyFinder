



import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/presentation/provider/sample_count.dart';

class SampleCounter extends ConsumerWidget
{
  const SampleCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) 
  {
    var countChanger = ref.read(sampleCountProvider.notifier);
    var count = ref.watch(sampleCountProvider);

    return new Row(
      children: [
        Text("$count"),
        new TextButton(
          onPressed: () => {
            countChanger.add()
          }, 
          child: Text("押す")
        )
      ],
    );
  }
  
}