import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../../widgets/button_widget.dart';

import '../../service/toast_tool.dart';
import '../../service/config_tool.dart';

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
  void dispose() {
    _cashMoneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RhColors.colorAppBar,
        brightness: Brightness.dark,
        title: Text('提现',
            style: TextStyle(
                color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            child: Column(children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(90),
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: RhColors.colorWhite),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('到账银行',
                          style: TextStyle(
                              color: RhColors.colorTitle,
                              fontSize: RhFontSize.fontSize16,
                              fontWeight: FontWeight.bold)),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: RhFontSize.fontSize14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '中国工商银行',
                                  style: TextStyle(color: RhColors.colorTitle)),
                              TextSpan(
                                  text: '（3053）',
                                  style:
                                      TextStyle(color: RhColors.colorPrimary))
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
                    color: RhColors.colorWhite),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    height: ScreenUtil().setHeight(90),
                    child: Text('提现金额',
                        style: TextStyle(
                            color: RhColors.colorTitle,
                            fontSize: RhFontSize.fontSize16,
                            fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                    controller: this._cashMoneyController,
                    style: TextStyle(
                        color: RhColors.colorPrimary,
                        fontSize: RhFontSize.fontSize18,
                        fontWeight: FontWeight.bold),
                    cursorColor: RhColors.colorPrimary,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '请输入提现金额',
                      hintStyle: TextStyle(fontSize: RhFontSize.fontSize18),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                    ),
                  ),
                  Divider(height: 1),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Row(
                    children: <Widget>[
                      Text('可提现金额 $_withdrawable 元',
                          style: TextStyle(
                              fontSize: RhFontSize.fontSize14,
                              color: RhColors.colorDesc)),
                      SizedBox(width: ScreenUtil().setWidth(30)),
                      InkWell(
                        onTap: () {
                          this.setState(() {
                            _cashMoneyController.text = this._withdrawable;
                          });
                        },
                        child: Text('全部提现',
                            style: TextStyle(
                                fontSize: RhFontSize.fontSize14,
                                color: RhColors.colorPrimary)),
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
                    final _moneyRegExp = new RegExp(
                        r'^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$');
                    if (this._cashMoneyController.text == '') {
                      ToastTool.toastWidget(context, msg: '请输入提现金额');
                    } else if (!_moneyRegExp
                        .hasMatch(this._cashMoneyController.text)) {
                      ToastTool.toastWidget(context, msg: '提现金额需大于0且最多两位小数');
                    } else if (double.parse(this._cashMoneyController.text) >
                        double.parse(this._withdrawable)) {
                      ToastTool.toastWidget(context, msg: '提现金额不能超过可提现金额');
                    } else {
                      print(this._cashMoneyController.text);
                    }
                  })
            ]),
          )),
    );
  }
}
