import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:webf/webf.dart';

class SimpleScreen extends StatefulWidget {
  const SimpleScreen({Key? key}) : super(key: key);

  @override
  State<SimpleScreen> createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    final Size viewportSize = queryData.size;
    AppBar appBar = AppBar(
      title: const Text('Simple Screen'),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Simple Screen'),
      ),
      body: WebF(
        bundle: WebFBundle.fromUrl('http://10.143.51.30:8080/front-end/dist/'),
        // bundle: WebFBundle.fromUrl('assets:///front-end/dist/index.html'),
        background: Colors.white,
        viewportWidth: viewportSize.width - queryData.padding.horizontal,
        viewportHeight: viewportSize.height - appBar.preferredSize.height - queryData.padding.vertical,
      ),
    );
  }
}
