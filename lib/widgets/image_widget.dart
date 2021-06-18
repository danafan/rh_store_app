import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWidget extends StatefulWidget {
  List imageFileList;
  final callBack;
  
  ImageWidget({this.imageFileList,this.callBack});
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.file(
        widget.imageFileList[0],
        width: ScreenUtil().setWidth(195),
        height: ScreenUtil().setWidth(195),
        fit: BoxFit.cover,
      ),
      onTap: () {
        var arg = {'images': widget.imageFileList, 'index': 0, 'heroTag': '111'};
        Navigator.pushNamed(context, '/photo_view', arguments: arg);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          enableDrag: false, //设置不能拖拽关闭
          builder: (BuildContext context) {
            return Container(
              height: ScreenUtil().setHeight(160),
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        widget.callBack();
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: ScreenUtil().setHeight(58),
                          alignment: Alignment.center,
                          child: Text('删除',
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: 16)))),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: ScreenUtil().setHeight(50),
                          alignment: Alignment.center,
                          child: Text('取消',
                              style: TextStyle(
                                  color: Color(0xffe25d2b), fontSize: 16)))),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
