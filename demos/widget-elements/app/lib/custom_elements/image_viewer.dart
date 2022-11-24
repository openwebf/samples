import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:webf/webf.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class FlutterImageViewerElement extends WidgetElement {
  FlutterImageViewerElement(BindingContext? context) : super(context);

  final List<String> _imageUrls = [];
  List<String> get imageUrls => _imageUrls;
  set imageUrls(value) {
    if (value is! List) return;
    imageUrls.clear();
    for (var element in value) {
      imageUrls.add(element);
    }
  }

  bool _visible = false;

  bool get visible => _visible;
  set visible(value) {
    if (value is String) {
      _visible = value == 'true';
      return;
    }
    _visible = value == true;
  }

  bool _isShowing = false;

  @override
  void initializeAttributes(Map<String, ElementAttributeProperty> attributes) {
    super.initializeAttributes(attributes);
    attributes['images'] = ElementAttributeProperty(getter: () => jsonEncode(imageUrls), setter: (value) => imageUrls = jsonEncode(value));
    attributes['visible'] = ElementAttributeProperty(getter: () => visible.toString(), setter: (value) => visible = value);
  }

  @override
  void initializeProperties(Map<String, BindingObjectProperty> properties) {
    super.initializeProperties(properties);
    properties['images'] = BindingObjectProperty(getter: () => imageUrls, setter: (value) => imageUrls = value);
    properties['visible'] = BindingObjectProperty(getter: () => visible, setter: (value) => visible = value);
  }

  @override
  void propertyDidUpdate(String key, value) {
    super.propertyDidUpdate(key, value);

    showImageViewer();
  }

  @override
  void attributeDidUpdate(String key, String value) {
    super.attributeDidUpdate(key, value);

    showImageViewer();
  }

  void showImageViewer() {
    if (visible && imageUrls.isNotEmpty && !_isShowing) {
      _isShowing = true;
      List<ImageProvider> providers = imageUrls.map((url) => Image.network(url).image).toList();
      MultiImageProvider multiImageProvider = MultiImageProvider(providers);
      showImageViewerPager(_buildContext, multiImageProvider, immersive: false, onViewerDismissed: (page) {
        dispatchEvent(Event('close'));
        _isShowing = false;
      });
    }
  }

  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context, List<Widget> children) {
    _buildContext = context;
    return Container();
  }
}
