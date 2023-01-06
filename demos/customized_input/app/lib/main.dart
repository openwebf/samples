import 'package:flutter/material.dart';
import 'package:webf/devtools.dart';
import 'package:webf/webf.dart';
import 'package:webf_websocket/webf_websocket.dart';

void main() {
  WebFWebSocket.initialize();
  WebF.defineCustomElement('flutter-input', (context) => FlutterInput(context));
  runApp(const MyApp());
}

class FlutterInput extends WidgetElement {
  FlutterInput(super.context);

  TextEditingController controller = TextEditingController();

  @override
  void initializeProperties(Map<String, BindingObjectProperty> properties) {
    super.initializeProperties(properties);

    properties['value'] = BindingObjectProperty(
        getter: () => controller.value.text,
        setter: (value) => controller.text = value);
  }

  final focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context, List<Widget> children) {
    return KeyboardListener(
        focusNode: focusNode,
        onKeyEvent: (event) {
          if (event.logicalKey.keyLabel == 'Enter') {
            dispatchEvent(Event('enterkeyboard'));
          }
        },
        child: TextField(
          controller: controller,
        ));
  }
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
    AppBar appBar = AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text(widget.title),
    );

    final Size viewportSize = queryData.size;
    return Scaffold(
        appBar: appBar,
        body: WebF(
          viewportWidth: viewportSize.width - queryData.padding.horizontal,
          viewportHeight: viewportSize.height -
              appBar.preferredSize.height -
              queryData.padding.vertical,
          bundle: WebFBundle.fromUrl('http://localhost:3000'),
          devToolsService: ChromeDevToolsService(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
