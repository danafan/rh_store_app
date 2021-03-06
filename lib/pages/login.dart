import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../widgets/button_widget.dart';

import '../service/toast_tool.dart';
import '../service/config_tool.dart';

class Login extends StatefulWidget {
  final Map arguments;
  Login({this.arguments});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //手机号输入框
  final _phoneController = TextEditingController();
  //验证码输入框
  final _codeController = TextEditingController();
  //手机号正则
  final _phoneRegExp = new RegExp(r'^1[3456789]\d{9}$');
  //倒计时计时器
  var _timer;
  //倒计时时间
  int _countdownTime = 60;
  //获取验证码文字
  String _codeText = "获取验证码";

  @override
  void dispose() {
    this._phoneController.dispose();
    this._codeController.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: RhColors.colorAppBar,
          brightness: Brightness.dark,
          title: Text(widget.arguments['pageType'] == '1' ? '新商户签约' : '商户登录',
              style: TextStyle(color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 触摸收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setWidth(50),
                  horizontal: ScreenUtil().setHeight(60)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  Text(widget.arguments['pageType'] == '1' ? '新商户签约' : '商户登录',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  Container(
                      decoration: BoxDecoration(
                          color: RhColors.colorLine,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: this._phoneController,
                        style:
                            TextStyle(color: RhColors.colorTitle, fontSize: RhFontSize.fontSize16),
                        cursorColor: RhColors.colorTitle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '请输入手机号码',
                          hintStyle: TextStyle(fontSize: RhFontSize.fontSize16),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                        ),
                      )),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Container(
                      decoration: BoxDecoration(
                          color: RhColors.colorLine,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextField(
                            controller: this._codeController,
                            style: TextStyle(
                                color: RhColors.colorTitle, fontSize: RhFontSize.fontSize16),
                            cursorColor: RhColors.colorTitle,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '请输入验证码',
                              hintStyle: TextStyle(fontSize: RhFontSize.fontSize16),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(15)),
                            ),
                          )),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          InkWell(
                            onTap: () {
                              if (this._countdownTime == 60) {
                                if (this._phoneController.text == '') {
                                  ToastTool.toastWidget(context, msg: '请输入手机号');
                                } else if (!_phoneRegExp
                                    .hasMatch(this._phoneController.text)) {
                                  ToastTool.toastWidget(context,
                                      msg: '请输入正确的手机号');
                                } else {
                                  this._startCountdownTimer();
                                }
                              } else {
                                ToastTool.toastWidget(context, msg: '操作频繁');
                              }
                            },
                            child: Container(
                                width: ScreenUtil().setWidth(220),
                                alignment: Alignment.center,
                                child: Text(
                                  _codeText,
                                  style: TextStyle(
                                      color: this._countdownTime == 6
                                          ? RhColors.colorPrimary
                                          : RhColors.colorDesc),
                                )),
                          ),
                        ],
                      )),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  ButtonWidget(
                      text: widget.arguments['pageType'] == '1' ? '提交' : '登录',
                      buttonBack: () {
                        if (widget.arguments['pageType'] == '1') {
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/into_certificate', (route) => route == null);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/navigator', (route) => route == null);
                        }
                        // if (this._phoneController.text == '') {
                        //ToastTool.toastWidget(context, msg: '请输入手机号');
                        // } else if (!_phoneRegExp
                        //     .hasMatch(this._phoneController.text)) {
                        //ToastTool.toastWidget(context, msg: '请输入正确的手机号');
                        // } else if (this._codeController.text == '') {
                        //ToastTool.toastWidget(context, msg: '请输入验证码');
                        // } else {
                        //   print('提交');
                        // }
                      })
                ],
              ),
            )));
  }

  //获取验证码
  _startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      this.setState(() {
        _timer = timer;
        if (this._countdownTime >= 1) {
          this._countdownTime = this._countdownTime - 1;
          this._codeText = '重新获取' + this._countdownTime.toString() + 's';
        } else {
          this._timer.cancel();
          this._countdownTime = 60;
          this._codeText = '获取验证码';
        }
      });
    });
  }
}
