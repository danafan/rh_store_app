import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatefulWidget {
  final controller;
  String hintText;
  String keyboardType;

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
      style: TextStyle(color: Color(0xff333333), fontSize: 14),
      keyboardType: widget.keyboardType == '1'
          ? TextInputType.text
          : TextInputType.number,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 14),
          border: InputBorder.none),
    ));
  }
}
