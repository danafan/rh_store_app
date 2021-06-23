import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogWidget extends StatefulWidget {
  String title;
  var content_widget;
  final cancel_fun;
  final confirm_fun;
  String cancel_text;
  String confim_text;
  DialogWidget(
      {this.title,
      this.content_widget,
      this.cancel_fun,
      this.confirm_fun,
      this.cancel_text = '取消',
      this.confim_text = '确认'});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
              height: ScreenUtil().setHeight(80),
              alignment: Alignment.center,
              child: Text('${widget.title}',
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
          Divider(height: ScreenUtil().setHeight(1)),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            child: widget.content_widget,
          ),
          Divider(height: ScreenUtil().setHeight(1)),
          Container(
              height: ScreenUtil().setHeight(68),
              child: Row(children: <Widget>[
                Expanded(
                    child: InkWell(
                        onTap: () {
                          widget.cancel_fun();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              widget.cancel_text,
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: 14),
                            )))),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          widget.confirm_fun();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffe25d2b),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5))),
                            alignment: Alignment.center,
                            child: Text(widget.confim_text,
                                style: TextStyle(
                                    color: Color(0xffffffff), fontSize: 14)))))
              ]))
        ])));
  }
}
