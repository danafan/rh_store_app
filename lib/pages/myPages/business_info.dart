import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class BusinessInfo extends StatefulWidget {
  @override
  _BusinessInfoState createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff0a0b17),
            brightness: Brightness.dark,
            title: Text(
              '营业资质',
              style: TextStyle(color: Color(0xffffffff), fontSize: 18),
            )),
        body: SingleChildScrollView(
            child: Container(
          width: ScreenUtil().setWidth(750),
          padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _titleWidget('经营者身份证正面'),
              SizedBox(height: ScreenUtil().setWidth(20)),
              _imageWidget(
                  'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg'),
              SizedBox(height: ScreenUtil().setWidth(20)),
              _titleWidget('经营者身份证反面'),
              SizedBox(height: ScreenUtil().setWidth(20)),
              _imageWidget(
                  'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg'),
              SizedBox(height: ScreenUtil().setWidth(20)),
              _titleWidget('营业执照'),
              SizedBox(height: ScreenUtil().setWidth(20)),
              _imageWidget(
                  'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg'),
              SizedBox(height: ScreenUtil().setWidth(20)),
              _titleWidget('食品经营许可证'),
              SizedBox(height: ScreenUtil().setWidth(20)),
              _imageWidget(
                  'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg'),
              SizedBox(height: ScreenUtil().setWidth(20)),
            ],
          ),
        )));
  }

  //标题
  _titleWidget(text) {
    return Text(text,
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 14,
            fontWeight: FontWeight.bold));
  }

  //图片
  _imageWidget(url) {
    return InkWell(
        onTap: () {
          var arg = {
            'images': [
              'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg'
            ],
            'index': 0,
            'heroTag': '111'
          };
          Navigator.pushNamed(context, '/photo_view', arguments: arg);
        },
        child: Container(
          height: ScreenUtil().setHeight(300),
          width: ScreenUtil().setWidth(500),
          child: Image.network(url, fit: BoxFit.scaleDown),
        ));
  }
}
