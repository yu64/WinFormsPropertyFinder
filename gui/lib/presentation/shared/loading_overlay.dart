


import 'package:flutter/material.dart';

@immutable
class LoadingOverlay<F> extends StatelessWidget 
{
  final Future<F> future;
  final F initData;
  final Widget Function(F) loadedWidgetFunc;
  final Widget Function()? loadingWidgetFunc;
  final Widget Function(Object?)? errorWidgetFunc;



  const LoadingOverlay({

    required this.future,
    required this.initData,
    required this.loadedWidgetFunc,
    this.errorWidgetFunc,
    this.loadingWidgetFunc,
    super.key
  });
  


  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder<F>(
      future: this.future, 
      builder: (ctx, snapshot) {

        final state = snapshot.connectionState;

        final loadingWidgetFunc = this.loadingWidgetFunc ?? () => const CircularProgressIndicator();
        final errorWidgetFunc = this.errorWidgetFunc ?? () => Text("ERROR: ${snapshot.error?.toString()}");
        
        //再読み込みの場合、前回の値を使用
        final data = snapshot.data ?? this.initData;


        return Stack(
          children: <Widget?>[
            
            this.loadedWidgetFunc(data),
            (state != ConnectionState.done ? loadingWidgetFunc() : null),
            (snapshot.hasError ? errorWidgetFunc(snapshot.error) : null),

          ].nonNulls.toList(),
        );
      }
    );
  }



}