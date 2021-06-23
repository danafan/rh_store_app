import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../service/picker_tool.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/row_widget.dart';
import '../../widgets/text_field.dart';
import '../../service/toast_tool.dart';

class EditBank extends StatefulWidget {
  @override
  _EditBankState createState() => _EditBankState();
}

class _EditBankState extends State<EditBank> {
  //账户类型列表
  List _accountTypeList = [
    {'id': 'ACCOUNT_TYPE_BUSINESS', 'name': '对公银行账户'},
    {'id': 'ACCOUNT_TYPE_PRIVATE', 'name': '经营者个人银行卡'}
  ];
  //默认选中的账户类型下标
  int _accountTypeIndex = 0;

  //开户银行列表
  List _bankList = ['中国银行', '农业银行', '工商银行', '建设银行', '交通银行', '招商银行', '邮政储蓄银行'];
  //默认选中的开户银行下标
  int _bankIndex = 0;

  //开户地址列表
  List _addressList = [
    {'id': '152201', 'name': '乌兰浩特市'},
    {'id': '152223', 'name': '扎赉特旗'},
    {'id': '152200', 'name': '兴安盟'}
  ];
  //默认选中的开户地址下标
  int _addressIndex = 0;

  //输入框Controller
  final _countController = new TextEditingController();

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
        title: Text('设置银行卡',
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
                children: <Widget>[
                  RowWidget(
                      label: '账户类型',
                      expandWidget: Expanded(
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                List _nameList = [];
                                for (var i = 0;
                                    i < this._accountTypeList.length;
                                    i++) {
                                  _nameList
                                      .add(this._accountTypeList[i]['name']);
                                }
                                JhPickerTool.showStringPicker(context,
                                    data: _nameList,
                                    clickCallBack: (int index, var str) {
                                  this.setState(() {
                                    _accountTypeIndex = index;
                                  });
                                }, normalIndex: this._accountTypeIndex);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(100),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        this._accountTypeList[
                                            this._accountTypeIndex]['name'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff333333))),
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(8)),
                                  Icon(Icons.arrow_forward_ios,
                                      size: 16, color: Color(0xff8a8a8a))
                                ],
                              ))),
                      alignment: 'center'),
                  RowWidget(
                      label: '开户银行',
                      expandWidget: Expanded(
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                JhPickerTool.showStringPicker(context,
                                    data: this._bankList,
                                    clickCallBack: (int index, var str) {
                                  this.setState(() {
                                    _bankIndex = index;
                                  });
                                }, normalIndex: this._bankIndex);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(100),
                                    alignment: Alignment.centerLeft,
                                    child: Text(this._bankList[this._bankIndex],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff333333))),
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(8)),
                                  Icon(Icons.arrow_forward_ios,
                                      size: 16, color: Color(0xff8a8a8a))
                                ],
                              ))),
                      alignment: 'center'),
                  RowWidget(
                      label: '银行卡号',
                      expandWidget: TextFieldWidget(
                          controller: this._countController,
                          hintText: '输入银行卡号',
                          keyboardType: '2'),
                      alignment: 'center'),
                  RowWidget(
                      label: '开户地址',
                      expandWidget: Expanded(
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                List _nameList = [];
                                for (var i = 0;
                                    i < this._addressList.length;
                                    i++) {
                                  _nameList.add(this._addressList[i]['name']);
                                }
                                JhPickerTool.showStringPicker(context,
                                    data: _nameList,
                                    clickCallBack: (int index, var str) {
                                  this.setState(() {
                                    _addressIndex = index;
                                  });
                                }, normalIndex: this._addressIndex);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: ScreenUtil().setHeight(100),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        this._addressList[this._addressIndex]
                                            ['name'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff333333))),
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(8)),
                                  Icon(Icons.arrow_forward_ios,
                                      size: 16, color: Color(0xff8a8a8a))
                                ],
                              ))),
                      alignment: 'center'),
                  Container(
                    padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '提交审核后，系统会自动汇款0.01元至新账户，验证是否可正常使用。',
                          style:
                              TextStyle(color: Color(0xffe25d2b), fontSize: 12),
                        ),
                        Text('可在【银行卡】页面查看审核结果',
                            style: TextStyle(
                                color: Color(0xffe25d2b), fontSize: 12))
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  ButtonWidget(
                      text: '提交审核',
                      buttonBack: () {
                        final _countRegExp = new RegExp(r'^\d{1,30}$');
                        if (this._countController.text == '') {
                          ToastTool.toastWidget(context, msg: '请输入银行卡号');
                        } else if (!_countRegExp
                            .hasMatch(this._countController.text)) {
                          ToastTool.toastWidget(context,
                              msg: '请输入正确的银行卡格式，1-30位纯数字');
                        } else {
                          Map req = {
                            'sub_mchid': '特约商户号，用户信息内获取',
                            'account_type':
                                this._accountTypeList[_accountTypeIndex]['id'],
                            'account_bank': this._bankList[_bankIndex],
                            'bank_address_code':
                                this._addressList[_addressIndex]['id'],
                            'account_number': this._countController.text
                          };
                          ToastTool.toastWidget(context, msg: '提交成功');
                          print(req);
                        }
                      })
                ],
              ))),
    );
  }
}
