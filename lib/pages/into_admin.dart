import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button_widget.dart';
import '../widgets/row_widget.dart';
import '../widgets/text_field.dart';

import '../service/picker_tool.dart';
import '../service/toast_tool.dart';
import '../service/config_tool.dart';

class IntoAdmin extends StatefulWidget {
  @override
  _IntoAdminState createState() => _IntoAdminState();
}

class _IntoAdminState extends State<IntoAdmin> {
  //管理员类型列表
  List _adminTypeList = [
    {'id': '65', 'name': '经营者/法人'},
    {'id': '66', 'name': '负责人'}
  ];
  //选中的类型下标
  int _activeIndex = 0;

  //管理员姓名
  final _nameController = new TextEditingController();
  //身份证号
  final _cardIdController = new TextEditingController();
  //手机号
  final _phoneController = new TextEditingController();
  //邮箱
  final _emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this._nameController.dispose();
    this._cardIdController.dispose();
    this._phoneController.dispose();
    this._emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RhColors.colorAppBar,
        brightness: Brightness.dark,
        title: Text('超级管理员信息',
            style: TextStyle(
                color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
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
                        color: Color(0x0ce25d2b),
                        border: Border(
                            bottom: BorderSide(color: RhColors.colorLine))),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(3)),
                    child: Text(
                      '超级管理员需在开户后进行签约，并可接收日常重要管理信息和进行资金操作，请确定其为商户法定代表人或负责人!',
                      style: TextStyle(
                          color: RhColors.colorPrimary,
                          fontSize: RhFontSize.fontSize12),
                    ),
                  ),
                  RowWidget(
                      label: '管理员类型',
                      expandWidget: Expanded(
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                List _nameList = [];
                                for (var i = 0;
                                    i < this._adminTypeList.length;
                                    i++) {
                                  _nameList.add(this._adminTypeList[i]['name']);
                                }
                                JhPickerTool.showStringPicker(context,
                                    data: _nameList,
                                    clickCallBack: (int index, var str) {
                                  this.setState(() {
                                    _activeIndex = index;
                                  });
                                }, normalIndex: this._activeIndex);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(100),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        this._adminTypeList[this._activeIndex]
                                            ['name'],
                                        style: TextStyle(
                                            fontSize: RhFontSize.fontSize14,
                                            color: RhColors.colorTitle)),
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(8)),
                                  Icon(Icons.arrow_forward_ios,
                                      size: 16, color: RhColors.colorDesc)
                                ],
                              ))),
                      alignment: 'center'),
                  RowWidget(
                      label: '管理员姓名',
                      expandWidget: TextFieldWidget(
                          controller: this._nameController,
                          hintText: '输入管理员姓名',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '身份证号码',
                      expandWidget: TextFieldWidget(
                          controller: this._phoneController,
                          hintText: '输入管理员身份证号码',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '管理员手机',
                      expandWidget: TextFieldWidget(
                          controller: this._cardIdController,
                          hintText: '输入管理员手机号码',
                          keyboardType: '2'),
                      alignment: 'center'),
                  RowWidget(
                      label: '管理员邮箱',
                      expandWidget: TextFieldWidget(
                          controller: this._emailController,
                          hintText: '输入管理员邮箱',
                          keyboardType: '1'),
                      alignment: 'center'),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonWidget(
                          text: '提交',
                          buttonBack: () {
                            ToastTool.toastWidget(context, msg: '请输入管理员姓名');
                            // if (this._nameController.text == '') {
                            // ToastTool.toastWidget(context, msg: '请输入管理员姓名');
                            // } else if (this._cardIdController.text == '') {
                            // ToastTool.toastWidget(context, msg: '请输入管理员身份证号码');
                            // } else if (this._cardIdController.text == '') {
                            // ToastTool.toastWidget(context, msg: '请输入管理员手机号码');
                            // } else if (this._emailController.text == '') {
                            // ToastTool.toastWidget(context, msg: '请输入管理员邮箱');
                            // } else {
                            //   Map req = {
                            //     'contact_type': this._adminTypeList[this._activeIndex]
                            //                 ['id'],
                            //     'contact_name': this._nameController.text,
                            //     'contact_id_card_number': this._cardIdController.text,
                            //     'mobile_phone': this._phoneController.text,
                            //     'contact_email': this._emailController.text,
                            //   };
                            //   Navigator.pushNamedAndRemoveUntil(context, '/navigator',(route) => route == null);
                            // }
                            Navigator.pushNamedAndRemoveUntil(context,
                                '/navigator', (route) => route == null);
                          })
                    ],
                  )
                ],
              ))),
    );
  }
}
