import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../service/picker_tool.dart';
import '../../widgets/button_widget.dart';

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
        title: Text('设置银行卡',
            style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: <Widget>[
              _rowItem(
                  '账户类型',
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      List _nameList = [];
                      for (var i = 0; i < this._accountTypeList.length; i++) {
                        _nameList.add(this._accountTypeList[i]['name']);
                      }
                      JhPickerTool.showStringPicker(context, data: _nameList,
                          clickCallBack: (int index, var str) {
                        this.setState(() {
                          _accountTypeIndex = index;
                        });
                      }, normalIndex: this._accountTypeIndex);
                    },
                    child: _rowExpandWidget(
                        this._accountTypeList[this._accountTypeIndex]['name']),
                  )),
              _rowItem(
                  '开户银行',
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      JhPickerTool.showStringPicker(context,
                          data: this._bankList,
                          clickCallBack: (int index, var str) {
                        this.setState(() {
                          _bankIndex = index;
                        });
                      }, normalIndex: this._bankIndex);
                    },
                    child: _rowExpandWidget(this._bankList[this._bankIndex]),
                  )),
              _bankCount(),
              _rowItem(
                  '开户地址',
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      List _nameList = [];
                      for (var i = 0; i < this._addressList.length; i++) {
                        _nameList.add(this._addressList[i]['name']);
                      }
                      JhPickerTool.showStringPicker(context, data: _nameList,
                          clickCallBack: (int index, var str) {
                        this.setState(() {
                          _addressIndex = index;
                        });
                      }, normalIndex: this._addressIndex);
                    },
                    child: _rowExpandWidget(
                        this._addressList[this._addressIndex]['name']),
                  )),
              Container(
                padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '提交审核后，系统会自动汇款0.01元至新账户，验证是否可正常使用。',
                      style: TextStyle(color: Color(0xffe25d2b), fontSize: 12),
                    ),
                    Text('可在【银行卡】页面查看审核结果',
                        style:
                            TextStyle(color: Color(0xffe25d2b), fontSize: 12))
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              ButtonWidget(
                  text: '提交审核',
                  buttonBack: () {
                    final _countRegExp = new RegExp(r'^\d{1,30}$');
                    if (this._countController.text == '') {
                      print('请输入银行卡号');
                    } else if (!_countRegExp
                        .hasMatch(this._countController.text)) {
                      print('请输入正确的银行卡格式，1-30位纯数字');
                    }else{
                      Map req = {
                        'sub_mchid':'特约商户号，用户信息内获取',
                        'account_type':this._accountTypeList[_accountTypeIndex]['id'],
                        'account_bank':this._bankList[_bankIndex],
                        'bank_address_code':this._addressList[_addressIndex]['id'],
                        'account_number':this._countController.text
                      };
                      print(req);
                    }
                  })
            ],
          )),
    );
  }

  //银行账号
  _bankCount() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20)),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(bottom: BorderSide(color: Color(0xffF1F6F9)))),
        child: Row(children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(150),
            child: Text('银行卡号',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
              child: TextField(
            controller: this._countController,
            style: TextStyle(color: Color(0xff333333), fontSize: 14),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: '输入银行卡号',
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none),
          ))
        ]));
  }

  //每一行
  _rowItem(title, _widget) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border(bottom: BorderSide(color: Color(0xffF1F6F9)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(150),
            child: Text(title,
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(child: _widget)
        ],
      ),
    );
  }

  //每一行后半部分
  _rowExpandWidget(name) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          alignment: Alignment.centerLeft,
          child: Text(name,
              style: TextStyle(fontSize: 14, color: Color(0xff333333)),
              overflow: TextOverflow.ellipsis),
        )),
        SizedBox(width: ScreenUtil().setWidth(8)),
        Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xff8a8a8a))
      ],
    );
  }
}
