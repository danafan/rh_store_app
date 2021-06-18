import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button_widget.dart';
import '../widgets/upload_img.dart';
import '../widgets/row_widget.dart';
import '../widgets/text_field.dart';
import '../widgets/image_widget.dart';

class IntoCertificate extends StatefulWidget {
  @override
  _IntoCertificateState createState() => _IntoCertificateState();
}

class _IntoCertificateState extends State<IntoCertificate> {
  //输入框Controller
  final _countController = new TextEditingController();
  //证件图片
  List _certificateImg = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0a0b17),
        title: Text('商户证件信息',
            style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
      ),
      body: SingleChildScrollView(
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RowWidget(
                      label: '商家名称',
                      expandWidget: TextFieldWidget(
                          controller: this._countController,
                          hintText: '商家名称，2~110个字符，支持括号',
                          keyboardType: '2'),
                      alignment: 'center'),
                  RowWidget(
                      label: '证件注册号',
                      expandWidget: TextFieldWidget(
                          controller: this._countController,
                          hintText: '注册号/统一社会信用代码',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '证件图片',
                      expandWidget: Container(
                          child: this._certificateImg.length == 0
                              ? UploadImg(callBack: (_imgFile) {
                                  this.setState(() {
                                    this._certificateImg.add(_imgFile);
                                  });
                                })
                              : ImageWidget(
                                  imageFileList: this._certificateImg,
                                  callBack: () {
                                    this.setState(() {
                                      this._certificateImg.removeAt(0);
                                    });
                                  })),
                      alignment: 'start'),
                  _toastWidget('*营业执照的证件图片'),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonWidget(
                          text: '提交审核',
                          buttonBack: () {
                            print('object');
                          })
                    ],
                  )
                ],
              ))),
    );
  }

  //底部提示
  _toastWidget(_text) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setHeight(3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _text,
            style: TextStyle(color: Color(0xffe25d2b), fontSize: 12),
          )
        ],
      ),
    );
  }

}
