import 'package:flutter/material.dart';
import 'package:webf/webf.dart';
import 'package:webf_websocket/webf_websocket.dart';

import 'menu_screen.dart';
import 'screens/simple_screen.dart';
import 'unity_element.dart';
import 'screens/no_interaction_screen.dart';

class FlutterTextElement extends WidgetElement {
  FlutterTextElement(BindingContext? context) : super(context);

  @override
  Widget build(BuildContext context, List<Widget> children) {
    return Text('HelloWorld');
  }
}

void main() {
  WebFWebSocket.initialize();
  WebF.defineCustomElement('flutter-unity', (context) => UnityElement(context));
  WebF.defineCustomElement('flutter-text', (context) => FlutterTextElement(context));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Unity Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(),
        '/simple': (context) => const SimpleScreen(),
        '/none': (context) => const NoInteractionScreen(),
      },
    );
  }
}
