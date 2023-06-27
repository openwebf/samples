import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:webf/webf.dart';

class UnityElement extends WidgetElement {
  UnityElement(BindingContext? context) : super(context);

  late UnityWidgetController _unityWidgetController;

  @override
  void initializeAttributes(Map<String, ElementAttributeProperty> attributes) {
    super.initializeAttributes(attributes);
  }

  @override
  void initializeMethods(Map<String, BindingObjectMethod> methods) {
    super.initializeMethods(methods);
    methods['setRotationSpeed'] = BindingObjectMethodSync(call: (List args) {
      print('post message: $args');
      setRotationSpeed(args[0]);
    });
  }


  void setRotationSpeed(double speed) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed.toString(),
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    print('Received scene loaded from unityj');
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
  }

  @override
  Widget build(BuildContext context, List<Widget> children) {
    return UnityWidget(
      onUnityCreated: _onUnityCreated,
      onUnityMessage: onUnityMessage,
      onUnitySceneLoaded: onUnitySceneLoaded,
      useAndroidViewSurface: true,
    );
  }
}
