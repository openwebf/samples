import 'package:flutter/widgets.dart';
import 'package:webf/webf.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FlutterRoundLoadingButtonElement extends WidgetElement {
  FlutterRoundLoadingButtonElement(BindingContext? context) : super(context);

  final RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  String _loadingStatus = 'init';
  String get loadingStatus => _loadingStatus;
  set loadingStatus(value) {
    if (value is! String) return;
    _loadingStatus = value;
  }

  @override
  void initializeAttributes(Map<String, ElementAttributeProperty> attributes) {
    super.initializeAttributes(attributes);
    attributes['loadingStatus'] = ElementAttributeProperty(getter: () => loadingStatus, setter: (value) => loadingStatus = value);
  }

  @override
  void initializeProperties(Map<String, BindingObjectProperty> properties) {
    super.initializeProperties(properties);
    properties['loadingStatus'] = BindingObjectProperty(getter: () => loadingStatus, setter: (value) => loadingStatus = value);
  }

  void _updateButtonStatus() {
    if (_isLoading && (loadingStatus == 'success' || loadingStatus == 'fail' || loadingStatus == 'init')) {
      if (loadingStatus == 'success') {
        controller.success();
      } else if (loadingStatus == 'fail') {
        controller.error();
      } else if (loadingStatus == 'init') {
        controller.reset();
      }
      _isLoading = false;
    }
  }

  @override
  void attributeDidUpdate(String key, value) {
    _updateButtonStatus();
  }

  @override
  void propertyDidUpdate(String key, value) {
    _updateButtonStatus();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context, List<Widget> children) {
    return ConstrainedBox(
      constraints:
          BoxConstraints.tightFor(width: renderStyle.width.computedValue, height: renderStyle.height.computedValue),
      child: RoundedLoadingButton(
        borderRadius: 4,
          controller: controller, onPressed: () {
            _isLoading = true;
            dispatchEvent(MouseEvent(EVENT_CLICK, detail: 1, view: ownerDocument.defaultView));
      }, child: children.isNotEmpty ? children[0] : const SizedBox.shrink()),
    );
  }
}
