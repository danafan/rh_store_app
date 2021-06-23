import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button_widget.dart';
import '../widgets/upload_img.dart';
import '../widgets/row_widget.dart';
import '../widgets/text_field.dart';
import '../widgets/image_widget.dart';
import '../service/picker_tool.dart';
import '../service/toast_tool.dart';

class IntoIdentity extends StatefulWidget {
  @override
  _IntoIdentityState createState() => _IntoIdentityState();
}

class _IntoIdentityState extends State<IntoIdentity> {
  //法人姓名
  final _nameController = new TextEditingController();
  //身份证号
  final _cardIdController = new TextEditingController();
  //人像面
  List _positiveImg = [];
  //国徽面
  List _reverseImg = [];
  //身份证有效期
  String _idCardValidTime = '长期';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0a0b17),
        brightness: Brightness.dark,
        title: Text('法人身份信息',
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
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffF1F6F9)))),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(3)),
                    child: Text(
                      '法人身份信息用途是为商家注册微信商户号，热乎优选承诺保护商家隐私安全，信息绝不外露，请放心填写!',
                      style: TextStyle(color: Color(0xffe25d2b), fontSize: 12),
                    ),
                  ),
                  RowWidget(
                      label: '法人姓名',
                      expandWidget: TextFieldWidget(
                          controller: this._nameController,
                          hintText: '法定代表人身份证姓名',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '身份证号码',
                      expandWidget: TextFieldWidget(
                          controller: this._cardIdController,
                          hintText: '法定代表人身份证号码',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '身份证正面',
                      expandWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          this._positiveImg.length == 0
                              ? UploadImg(callBack: (_imgFile) {
                                  this.setState(() {
                                    this._positiveImg.add(_imgFile);
                                  });
                                })
                              : ImageWidget(
                                  imageFileList: this._positiveImg,
                                  callBack: () {
                                    this.setState(() {
                                      this._positiveImg.removeAt(0);
                                    });
                                  }),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(3)),
                            child: Text(
                              '*法定代表人身份证人像面',
                              style: TextStyle(
                                  color: Color(0xffe25d2b), fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      alignment: 'start'),
                  RowWidget(
                      label: '身份证反面',
                      expandWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          this._reverseImg.length == 0
                              ? UploadImg(callBack: (_imgFile) {
                                  this.setState(() {
                                    this._reverseImg.add(_imgFile);
                                  });
                                })
                              : ImageWidget(
                                  imageFileList: this._reverseImg,
                                  callBack: () {
                                    this.setState(() {
                                      this._reverseImg.removeAt(0);
                                    });
                                  }),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(3)),
                            child: Text(
                              '*法定代表人身份证国徽面',
                              style: TextStyle(
                                  color: Color(0xffe25d2b), fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      alignment: 'start'),
                  RowWidget(
                      label: '证件有效期',
                      expandWidget: Expanded(
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                JhPickerTool.showDatePicker(context,
                                    dateType: DateType.YMD,
                                    minValue: DateTime(2020, 08, 01),
                                    clickCallback: (var str, var time) {
                                  this.setState(() {
                                    _idCardValidTime = str;
                                  });
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(100),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Text(_idCardValidTime,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff333333))),
                                        SizedBox(
                                            width: ScreenUtil().setWidth(10)),
                                        Offstage(
                                            offstage: _idCardValidTime == '长期',
                                            child: InkWell(
                                              onTap: () {
                                                this.setState(() {
                                                  _idCardValidTime = '长期';
                                                });
                                              },
                                              child: Icon(
                                                Icons.cancel,
                                                color: Color(0xff8a8a8a),
                                                size: 18,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(8)),
                                  Icon(Icons.arrow_forward_ios,
                                      size: 16, color: Color(0xff8a8a8a))
                                ],
                              ))),
                      alignment: 'center'),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonWidget(
                          text: '提交',
                          buttonBack: () {
                            // if (this._nameController.text == '') {
                              // ToastTool.toastWidget(context, msg: '请输入法人真实姓名');
                            // } else if (this._cardIdController.text == '') {
                              // ToastTool.toastWidget(context, msg: '请输入法人身份证号码');
                            // } else if (this._positiveImg.length == 0) {
                               // ToastTool.toastWidget(context, msg: '请上传法人身份证人像面图片');
                            // } else if (this._reverseImg.length == 0) {
                              // ToastTool.toastWidget(context, msg: '请上传法人身份证国徽面图片');
                            // } else {
                            //   Map req = {
                            //     'id_card_name': this._nameController.text,
                            //     'id_card_number': this._cardIdController.text,
                            //     'id_card_copy': this._positiveImg[0],
                            //     'id_card_national': this._reverseImg[0],
                            //     'id_card_valid_time':this._idCardValidTime
                            //   };
                            //   print(req);
                            // }
                            Navigator.pushNamed(context, '/into_admin');
                          })
                    ],
                  )
                ],
              ))),
    );
  }
}
