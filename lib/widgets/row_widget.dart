import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/config_tool.dart';

class RowWidget extends StatefulWidget {
  final String label;
  final Widget expandWidget;
  final String alignment;
  
  RowWidget({this.label,this.expandWidget,this.alignment});
  @override
  _RowWidgetState createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: widget.alignment == 'start'
                ? ScreenUtil().setHeight(15)
                : ScreenUtil().setHeight(5)),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(bottom: BorderSide(color: RhColors.colorLine))),
        child: Row(
            crossAxisAlignment: widget.alignment == 'start'
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(180),
                child: Text(widget.label,
                    style: TextStyle(
                        color: RhColors.colorTitle,
                        fontSize: RhFontSize.fontSize14,
                        fontWeight: FontWeight.bold)),
              ),
              widget.expandWidget
            ]));
  }
}
