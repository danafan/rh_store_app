import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/config_tool.dart';

class DialogWidget extends StatefulWidget {
  final String title;
  final dynamic contentWidget;
  final dynamic cancelFun;
  final dynamic confirmFun;
  final String cancelText;
  final String confimText;
  DialogWidget(
      {this.title,
      this.contentWidget,
      this.cancelFun,
      this.confirmFun,
      this.cancelText = '取消',
      this.confimText = '确认'});
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
                      color: RhColors.colorTitle,
                      fontSize: RhFontSize.fontSize16,
                      fontWeight: FontWeight.bold))),
          Divider(height: ScreenUtil().setHeight(1)),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            child: widget.contentWidget,
          ),
          Divider(height: ScreenUtil().setHeight(1)),
          Container(
              height: ScreenUtil().setHeight(68),
              child: Row(children: <Widget>[
                Expanded(
                    child: InkWell(
                        onTap: () {
                          widget.cancelFun();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              widget.cancelText,
                              style: TextStyle(
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize14),
                            )))),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          widget.confirmFun();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: RhColors.colorPrimary,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5))),
                            alignment: Alignment.center,
                            child: Text(widget.confimText,
                                style: TextStyle(
                                    color: RhColors.colorWhite,
                                    fontSize: RhFontSize.fontSize14)))))
              ]))
        ])));
  }
}
