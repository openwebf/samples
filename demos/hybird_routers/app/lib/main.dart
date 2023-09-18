import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:webf/webf.dart';

void main() {
  runApp(const MaterialApp(
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    final Size viewportSize = queryData.size;
    WebF? webf;
    AppBar appBar = AppBar(
      title: const Text('Second Route'),
    );
    return WillPopScope(
        child: Scaffold(
          appBar: appBar,
          body: Center(
              child: webf = WebF(
                  viewportWidth:
                      viewportSize.width - queryData.padding.horizontal,
                  viewportHeight: viewportSize.height -
                      appBar.preferredSize.height -
                      queryData.padding.vertical,
                  bundle: WebFBundle.fromUrl('http://localhost:8080'))),
        ),
        onWillPop: () async {
          HistoryModule history = webf!.controller!.history;
          Queue<HistoryItem> stack = webf.controller!.previousHistoryStack;
          if (stack.length == 1) {
            // Return the previous flutter page when at the last page
            return true;
          }
          // Otherwise return back in vue app.
          history.back();
          return false;
        });
  }
}
