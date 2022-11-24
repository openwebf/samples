import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webf/webf.dart';

class _Action {
  _Action(this.name, this.value, {this.subname});

  final String name;
  final String? subname;
  final dynamic value;

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value, 'subname': subname};
  }
}

class FlutterActionSheetElement extends WidgetElement {
  FlutterActionSheetElement(BindingContext? context) : super(context);

  BuildContext? _buildContext;
  List<_Action> actions = [];
  Widget? popUpChildren;
  bool isPoping = false;

  String? _cachedActions;
  List<_Action> _buildActions(List<dynamic>? value) {
    if (value == null) return [];
    List<_Action> newActions = List.generate(value.length, (index) {
      Map<String, dynamic> v = value[index];
      return _Action(v['name'] ?? '', v['value'], subname: v['subname']);
    });
    _cachedActions = jsonEncode(newActions);
    return newActions;
  }

  @override
  void initializeProperties(Map<String, BindingObjectProperty> properties) {
    super.initializeProperties(properties);
    properties['visible'] = BindingObjectProperty(
        getter: () => visible, setter: (value) => visible = value);
    properties['actions'] = BindingObjectProperty(getter: () => actions, setter: (value) => actions = _buildActions(value));
  }

  @override
  void initializeAttributes(Map<String, ElementAttributeProperty> attributes) {
    super.initializeAttributes(attributes);
    attributes['actions'] = ElementAttributeProperty(
        getter: () => _cachedActions ?? '',
        setter: (value) => actions = _buildActions(jsonDecode(value)));
    attributes['visible'] = ElementAttributeProperty(
        getter: () {
          return visible.toString();
        },
        setter: (value) => visible = value);
  }

  @override
  void propertyDidUpdate(String key, value) {
    _showBottomSheet();
  }

  @override
  void attributeDidUpdate(String key, value) {
    _showBottomSheet();
  }

  void _showBottomSheet() {
    if (visible && !isPoping && _buildContext != null) {
      isPoping = true;
      showModalBottomSheet(context: _buildContext!, builder: builder)
          .whenComplete(() {
        dispatchEvent(Event('close'));
        visible = false;
        isPoping = false;
      });
    }
  }

  Widget builder(BuildContext context) {
    final theme = Theme.of(context);

    if (popUpChildren != null) {
      return Portal(
        webFElement: this,
        child: popUpChildren,
      );
    }

    return ListView(
      children: [
        Wrap(
            children: List.generate(actions.length, (index) {
          return ListTile(
            title: Text(actions[index].name, style: theme.textTheme.bodyText1),
            subtitle: actions[index].subname != null
                ? Text(actions[index].subname!,
                    style: theme.textTheme.bodyText2)
                : null,
            onTap: () {
              Navigator.of(context).pop();
              dispatchEvent(CustomEvent('select',
                  detail: {'action': actions[index].toJson(), 'index': index}));
            },
          );
        }))
      ],
    );
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

  @override
  Widget build(BuildContext context, List<Widget> children) {
    _buildContext = context;
    if (children.isNotEmpty) {
      popUpChildren = children.first;
    }
    return const SizedBox(width: 0, height: 0);
  }
}
