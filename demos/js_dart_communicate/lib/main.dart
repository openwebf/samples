import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webf/webf.dart';
import 'package:audioplayers/audioplayers.dart';

List<String> webfPlugins = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String audioPlayerPlugin = await rootBundle.loadString('js_plugins/audio_player.js');
  webfPlugins.add(audioPlayerPlugin);

  // Register the connectivity module into WebF.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  AudioPlayer audioPlayer = AudioPlayer();

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  @override
  void initState() {
    super.initState();
    _initStreams();
    javaScriptChannel.onMethodCall = handleJSCall;
  }

  Future<void> playAudio(String audioPath) async {
    AssetSource source = AssetSource(audioPath);
    await audioPlayer.play(source);
    audioPlayer.state;
  }

  Future<dynamic> handleJSCall(String method, dynamic args) async {
    switch(method) {
      case 'playAudio':
        await playAudio(args[0]);
        return true;
      case 'pause':
        await audioPlayer.pause();
        return true;
    }

    return null;
  }

  void _initStreams() {
    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      javaScriptChannel.invokeMethod('setDuration', duration.inMilliseconds);
    });

    _positionSubscription = audioPlayer.onPositionChanged.listen(
          (p) {
            javaScriptChannel.invokeMethod('setPosition', p.inMilliseconds);
          }
    );

    _playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      javaScriptChannel.invokeMethod('setPlayerState', PlayerState.stopped.toString());
      javaScriptChannel.invokeMethod('setPosition', 0);
    });

    _playerStateChangeSubscription =
        audioPlayer.onPlayerStateChanged.listen((state) {
          javaScriptChannel.invokeMethod('setPlayerState', state.toString());
        });
  }

  WebFJavaScriptChannel javaScriptChannel = WebFJavaScriptChannel();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: WebF(
          bundle: WebFBundle.fromUrl('assets:///assets/bundle.html'),
          javaScriptChannel: javaScriptChannel,
          onControllerCreated: (controller) {
            for(int i = 0; i < webfPlugins.length; i ++) {
              controller.view.evaluateJavaScripts(webfPlugins[i]);
            }
          },
        ),
      ),
    );
  }
}
