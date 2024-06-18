import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'presentation/page/sample_home.dart';

/**
 * エントリーポイント
 */ 
void main() async
{
  await setupWindow();
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

