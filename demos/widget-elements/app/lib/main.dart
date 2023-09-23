import 'package:flutter/material.dart';
import 'package:webf/webf.dart';
import 'custom_elements/action_sheet.dart';
import 'custom_elements/button.dart';
import 'custom_elements/image_viewer.dart';
import 'custom_elements/round_loading_button.dart';
import 'custom_elements/cell.dart';

void main() {
  HttpCacheController.mode = HttpCacheMode.NO_CACHE;
  WebF.defineCustomElement(
      'flutter-action-sheet', (context) => FlutterActionSheetElement(context));
  WebF.defineCustomElement(
      'flutter-button', (context) => FlutterButton(context));
  WebF.defineCustomElement(
      'flutter-image-viewer', (context) => FlutterImageViewerElement(context));
  WebF.defineCustomElement('flutter-round-loading-button',
      (context) => FlutterRoundLoadingButtonElement(context));
  WebF.defineCustomElement('flutter-cell', (context) => FlutterCell(context));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final Size viewportSize = queryData.size;
    final AppBar appBar = AppBar(
      title: const Text('Using Flutter widgets in WebF'),
    );
    return Scaffold(
        appBar: appBar,
        body: WebF(
          viewportWidth: viewportSize.width - queryData.padding.horizontal,
          viewportHeight: viewportSize.height -
              appBar.preferredSize.height -
              queryData.padding.vertical,
          bundle: WebFBundle.fromUrl('http://localhost:8080/'),
        ));
  }
}
