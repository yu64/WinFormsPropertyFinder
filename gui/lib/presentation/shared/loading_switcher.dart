


import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

@immutable
class LoadingSwitcher<F> extends StatelessWidget 
{
  final Future<F> future;
  final Widget Function()? loadingWidgetFunc;
  final Widget Function(F)? loadedWidgetFunc;
  final Widget Function(Object?)? errorWidgetFunc;



  const LoadingSwitcher({

    required this.future,
    this.loadingWidgetFunc,
    this.loadedWidgetFunc,
    this.errorWidgetFunc,
    super.key
  });
  


  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder<F>(
      future: this.future, 
      builder: (ctx, snapshot) {

        final state = snapshot.connectionState;

        //読み込み失敗
        if(snapshot.hasError)
        {
          return this.errorWidgetFunc?.call(snapshot.error) ?? Text("ERROR: ${snapshot.error?.toString()}");
        }

        //読み込み完了
        if(state == ConnectionState.done)
        {
          return this.loadedWidgetFunc?.call(snapshot.data as F) ?? nil;
        }

        //読み込み中
        return this.loadingWidgetFunc?.call() ?? const CircularProgressIndicator();

      }
    );
  }

}