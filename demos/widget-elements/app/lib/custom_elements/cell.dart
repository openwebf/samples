import 'package:webf/webf.dart';
import 'package:flutter/material.dart';

class FlutterCell extends WidgetElement {
  FlutterCell(BindingContext? context) : super(context);

  Widget buildCellTitle() {
    return WebFHTMLElement(tagName: 'DIV', inlineStyle: const {
      'flex': '1'
    }, children: [
      Text(title!)
    ]);
  }

  Widget buildCellValue() {
    return WebFHTMLElement(tagName: 'DIV', inlineStyle: const {
      'position': 'relative',
      'overflow': 'hidden',
      'color': 'rgb(150, 151, 153)',
      'text-align': 'right',
    }, children: [
      Text(value!)
    ]);
  }
  
  String? get title => getAttribute('title');
  String? get value => getAttribute('value');

  @override
  Widget build(BuildContext context, List<Widget> children) {
    List<Widget> childs = [];
    
    if (title != null) {
      childs.add(buildCellTitle());
    }
    if (value != null) {
      childs.add(buildCellValue());
    }
    
    return WebFHTMLElement(tagName: 'DIV', inlineStyle: const {
      'position': 'relative',
      'display': 'flex',
      'width': '100%',
      'padding': '10px 16px 10px 16px',
      'overflow': 'hidden',
      'color': 'rgb(50, 50, 51)',
      'font-size': '14px',
      'background': 'white'
    }, children: childs);
  }
}
