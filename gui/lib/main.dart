import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/core/logger.dart';

import 'package:gui/presentation/finder/finder_page.dart';
import 'package:window_manager/window_manager.dart';


/**
 * 環境変数
 */
class Env {

  static const cuiPath = String.fromEnvironment('cui');

}


/**
 * エントリーポイント
 */ 
void main() async
{

  logger.i("エントリーポイント => window設定");
  await setupWindow();

  logger.i("window設定 => アプリ実行");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}


/**
 * ウィンドウ設定
 */
Future<void> setupWindow() async
{
  //初期化
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  //ウィンドウ設定
  WindowOptions windowOptions = const WindowOptions(
    size: Size(350, 800),
    center: false,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: "開発中のアプリ"
  );

  
  //開くまで待機する
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}




/**
 * 最上位の表示要素
 */
class MyApp extends StatelessWidget 
{

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FinderPage(),
    );
  }
}

