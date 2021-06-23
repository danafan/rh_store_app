import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/dialog_widget.dart';
import '../../service/toast_tool.dart';

class BankCard extends StatefulWidget {
  @override
  _BankCardState createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  //银行卡信息
  String _bankName = '';
  String _bankCount = '';
  List<Color> _backColorList = [];

  //银行卡主图色列表
  List _backgroundList = [
    {
      'bankName': '中国银行',
      'colors': [Color(0xffE52143), Color(0xffEF907F)]
    },
    {
      'bankName': '农业银行',
      'colors': [Color(0xff32806B), Color(0xff41A57D)]
    },
    {
      'bankName': '工商银行',
      'colors': [Color(0xffE85359), Color(0xffF09A66)]
    },
    {
      'bankName': '建设银行',
      'colors': [Color(0xff273E78), Color(0xff4176AB)]
    },
    {
      'bankName': '交通银行',
      'colors': [Color(0xff162FDC), Color(0xff499ACB)]
    },
    {
      'bankName': '招商银行',
      'colors': [Color(0xffE52F70), Color(0xffEB6A52)]
    },
    {
      'bankName': '邮政储蓄银行',
      'colors': [Color(0xff276450), Color(0xff62A46B)]
    }
  ];

  @override
  void initState() {
    super.initState();
    //获取银行卡信息
    this._getBankInfo();
  }

  //获取银行卡信息
  _getBankInfo() {
    String bankName = "农业银行";
    if (bankName != '') {
      this.setState(() {
        this._bankName = bankName;
        String bankCount = "546354756453625345";
        //星号列表
        String _xList = '';
        for (var x_i = 0; x_i < bankCount.length - 7; x_i++) {
          _xList += '*';
        }
        this._bankCount =
            bankCount.replaceRange(4, bankCount.length - 3, _xList);
        for (var i = 0; i < this._backgroundList.length; i++) {
          if (this._backgroundList[i]['bankName'] == this._bankName) {
            this._backColorList = this._backgroundList[i]['colors'];
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff0a0b17),
            brightness: Brightness.dark,
            title: Text(
              '银行卡管理',
              style: TextStyle(color: Color(0xffffffff), fontSize: 18),
            )),
        body: Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
          child: this._bankName == ''
              ? Center(
                  child: _notBindWidget(),
                )
              : _bankWidget(),
        ));
  }

  //没有绑定银行卡
  _notBindWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('这里是银行卡的审核状态',
            style: TextStyle(color: Color(0xff333333), fontSize: 14)),
        SizedBox(height: ScreenUtil().setHeight(10)),
        InkWell(
          onTap: () {
            Map arg = {'pageType': '1', 'id': ''};
            Navigator.pushNamed(context, '/edit_bank');
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffe25d2b),
                borderRadius: BorderRadius.circular(3)),
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(150),
            height: ScreenUtil().setHeight(60),
            child: Text('去绑定',
                style: TextStyle(color: Color(0xffffffff), fontSize: 13)),
          ),
        )
      ],
    );
  }

  //已绑定银行卡
  _bankWidget() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: this._backColorList,
              )),
          width: double.infinity,
          height: ScreenUtil().setHeight(180),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  SizedBox(width: ScreenUtil().setWidth(20)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("${this._bankName}",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: ScreenUtil().setHeight(5)),
                      Text('个人',
                          style:
                              TextStyle(color: Color(0xffffffff), fontSize: 14))
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('${this._bankCount}',
                      style: TextStyle(color: Color(0xffffffff), fontSize: 20))
                ],
              )
            ],
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(60)),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/edit_bank');
          },
          child: Container(
              width: ScreenUtil().setWidth(680),
              height: ScreenUtil().setHeight(80),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(40)),
                  border: Border.all(color: Color(0xffe25d2b))),
              child: Text(
                '更换',
                style: TextStyle(color: Color(0xffe25d2b), fontSize: 16),
              )),
        ),
        SizedBox(height: ScreenUtil().setHeight(20)),
        ButtonWidget(
            text: '解除绑定',
            buttonBack: () {
              showDialog<Null>(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: DialogWidget(
                        title: '提示',
                        content_widget: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(30)),
                          child: Text('确认解除绑定?'),
                        ),
                        cancel_fun: () {},
                        confirm_fun: () {
                          ToastTool.toastWidget(context, msg: '银行卡已解除');
                        }),
                  );
                },
              ).then((val) {});
            })
      ],
    );
  }
}
