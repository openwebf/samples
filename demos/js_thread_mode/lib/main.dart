/*
 * Copyright (C) 2019-2022 The Kraken authors. All rights reserved.
 * Copyright (C) 2022-present The WebF authors. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webf/devtools.dart';
import 'package:webf/webf.dart';

@pragma('vm:entry-point')
void mainWithoutNewEngine() => runApp(MyApp(showNewEngineButton: false));

void main() {
  runApp(MyApp(
    showNewEngineButton: true,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.showNewEngineButton});
  bool showNewEngineButton = true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kraken Browser',
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: FirstPage(
          title: 'Landing Bay', showNewEngineButton: showNewEngineButton),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage(
      {super.key, required this.title, required this.showNewEngineButton});
  final String title;
  final bool showNewEngineButton;

  @override
  State<StatefulWidget> createState() {
    return FirstPageState(showNewEngineButton: showNewEngineButton);
  }
}

enum ThreadMode {
  differentDedicated,
  sameDedicated,
  sameSingle,
}

class FirstPageState extends State<FirstPage> {
  FirstPageState({required this.showNewEngineButton});

  static const platform = MethodChannel('com.example.flutter/new_engine');
  final bool showNewEngineButton;

  DedicatedThreadGroup threadGroup = DedicatedThreadGroup();

  WebFController webFController(ThreadMode threadMode) {
    WebFThread runningThread = DedicatedThread();
    switch (threadMode) {
      case ThreadMode.differentDedicated:
        break;
      case ThreadMode.sameDedicated:
        runningThread = threadGroup.slave();
        break;
      case ThreadMode.sameSingle:
        runningThread = FlutterUIThread();
        break;
    }
    return WebFController(
      context,
      devToolsService: ChromeDevToolsService(),
      bundle: WebFBundle.fromUrl('assets:assets/bundle.html'),
      runningThread: runningThread,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebFDemo(
                controller: webFController(ThreadMode.differentDedicated));
          }));
        },
        child: const Text('Different dedicated thread'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebFDemo(
                controller: webFController(ThreadMode.sameDedicated));
          }));
        },
        child: const Text('Same dedicated thread'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebFDemo(controller: webFController(ThreadMode.sameSingle));
          }));
        },
        child: const Text('Same single thread'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebFDemoTwoPage(
                controller1: webFController(ThreadMode.differentDedicated),
                controller2: webFController(ThreadMode.differentDedicated));
          }));
        },
        child: const Text('Different dedicated thread (Two page)'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebFDemoTwoPage(
                controller1: webFController(ThreadMode.sameDedicated),
                controller2: webFController(ThreadMode.sameDedicated));
          }));
        },
        child: const Text('Same dedicated thread (Two page)'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebFDemoTwoPage(
                controller1: webFController(ThreadMode.sameSingle),
                controller2: webFController(ThreadMode.sameSingle));
          }));
        },
        child: const Text('Same single thread (Two page)'),
      ),
    ];

    if (showNewEngineButton) {
      buttons.add(const SizedBox(height: 20));
      buttons.add(ElevatedButton(
        onPressed: () async {
          try {
            await platform.invokeMethod('newFlutterEngine');
          } on PlatformException catch (e) {
            print("Failed to create engine: '${e.message}'.");
          }
        },
        child: const Text('FlutterEngineGroup（supported iOS/Android）'),
      ));
      buttons.add(const SizedBox(height: 20));
      buttons.add(ElevatedButton(
        onPressed: () async {
          try {
            await platform
                .invokeMethod('newFlutterEngineWithoutFlutterEngineGroup');
          } on PlatformException catch (e) {
            print("Failed to create engine: '${e.message}'.");
          }
        },
        child: const Text('New flutter engine without FlutterEngineGroup'),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttons,
        ),
      ),
    );
  }
}

class WebFDemo extends StatefulWidget {
  final WebFController controller;

  const WebFDemo({super.key, required this.controller});

  @override
  _WebFDemoState createState() => _WebFDemoState();
}

class _WebFDemoState extends State<WebFDemo> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('WebF Demo'),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: WebF(controller: widget.controller),
        ));
  }
}

class WebFDemoTwoPage extends StatefulWidget {
  final WebFController controller1;
  final WebFController controller2;

  const WebFDemoTwoPage({
    super.key,
    required this.controller1,
    required this.controller2,
  });

  @override
  _WebFDemoTwoPageState createState() => _WebFDemoTwoPageState();
}

class _WebFDemoTwoPageState extends State<WebFDemoTwoPage> {
  @override
  void dispose() {
    widget.controller1.dispose();
    widget.controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebF Demo'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double halfHeight = constraints.maxHeight / 2;
          return Column(
            children: [
              SizedBox(
                height: halfHeight,
                child: WebF(controller: widget.controller1),
              ),
              SizedBox(
                height: halfHeight,
                child: WebF(controller: widget.controller2),
              ),
            ],
          );
        },
      ),
    );
  }
}
