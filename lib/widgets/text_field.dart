import 'package:flutter/material.dart';

import '../service/config_tool.dart';

class TextFieldWidget extends StatefulWidget {
  final controller;
  final String hintText;
  final String keyboardType;

  TextFieldWidget({this.controller, this.hintText, this.keyboardType});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
      controller: widget.controller,
      style: TextStyle(
          color: RhColors.colorTitle, fontSize: RhFontSize.fontSize14),
      keyboardType: widget.keyboardType == '1'
          ? TextInputType.text
          : TextInputType.number,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: RhFontSize.fontSize14),
          border: InputBorder.none),
    ));
  }
}
