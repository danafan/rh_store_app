import 'package:flutter/material.dart';

import 'package:flutter_screenutil/screen_util.dart';
import '../../widgets/button_widget.dart';

class CashPage extends StatefulWidget {
  @override
  _CashPageState createState() => _CashPageState();
}

class _CashPageState extends State<CashPage> {
  //可提现金额
  String _withdrawable = '86.62';
  //输入的提现金额
  final _cashMoneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0a0b17),
        title: Text('提现',
            style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
        child: Column(children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(90),
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffffffff)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('到账银行',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  RichText(
                    text: TextSpan(
                        text: '中国工商银行',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff333333)),
                        children: <TextSpan>[
                          TextSpan(
                              text: '（3053）',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffe25d2b)))
                        ]),
                  )
                ]),
          ),
          SizedBox(height: ScreenUtil().setWidth(15)),
          Container(
            alignment: Alignment.centerLeft,
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffffffff)),
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                height: ScreenUtil().setHeight(90),
                child: Text('提现金额',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              TextField(
                controller: this._cashMoneyController,
                style: TextStyle(
                    color: Color(0xffe25d2b),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                cursorColor: Color(0xffe25d2b),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '请输入提现金额',
                  hintStyle: TextStyle(fontSize: 22),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15)),
                ),
              ),
              Divider(height: 1),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Row(
                children: <Widget>[
                  Text('可提现金额 ${_withdrawable} 元',
                      style: TextStyle(fontSize: 14, color: Color(0xff8a8a8a))),
                  SizedBox(width: ScreenUtil().setWidth(30)),
                  InkWell(
                    onTap: () {
                      this.setState(() {
                        _cashMoneyController.text = this._withdrawable;
                      });
                    },
                    child: Text('全部提现',
                      style: TextStyle(fontSize: 14, color: Color(0xffe25d2b))),
                  )
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(10))
            ]),
          ),
          SizedBox(height: ScreenUtil().setHeight(50)),
          ButtonWidget(
                text: '提现',
                buttonBack: () {
                  final _moneyRegExp = new RegExp(r'^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$');
                  if(this._cashMoneyController.text == ''){
                    print('请输入提现金额');
                  }else if(!_moneyRegExp.hasMatch(this._cashMoneyController.text)){
                    print('请输入正确提现金额,最多两位小数');
                  }else if(double.parse(this._cashMoneyController.text) > double.parse(this._withdrawable)){
                    print('提现金额不能超过可提现金额');
                  }else{
                    print(this._cashMoneyController.text);
                  }
                })
        ]),
      ),
    );
  }
}
