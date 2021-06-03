import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../widgets/button_widget.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size(ScreenUtil().setWidth(750), ScreenUtil().setHeight(180)),
          child: AppBar(
            backgroundColor: Color(0xff0a0b17),
            brightness: Brightness.dark,
            flexibleSpace: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).padding.top),
                _storeWidget()
              ],
            ),
          )),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(15),
                  right: ScreenUtil().setWidth(15)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffe4d9bb),
                    Color(0xfff2eae0),
                    Color(0xffebe3d0),
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '我的钱包',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/bill_page');
                            },
                            child: Text('账单>>',
                                style: TextStyle(
                                    color: Color(0xff8a8a8a), fontSize: 14)))
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _moneyWidget('钱包余额（元）', '0.00'),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/cash_page');
                              },
                              child: Container(
                                height: ScreenUtil().setHeight(42),
                                width: ScreenUtil().setWidth(120),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(21))),
                                child: Text(
                                  '提现',
                                  style: TextStyle(
                                      color: Color(0xff333333), fontSize: 14),
                                ),
                              ))
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _moneyWidget('昨日收入（元）', '0.00'),
                          SizedBox(width: ScreenUtil().setWidth(38)),
                          _moneyWidget('昨日支出（元）', '0.00')
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(15),
                  right: ScreenUtil().setWidth(15)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(70),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '系统工具',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(height: 1),
                  Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(30),
                        bottom: ScreenUtil().setHeight(30)),
                    alignment: Alignment.center,
                    child: Wrap(
                        spacing: ScreenUtil().setWidth(15),
                        runSpacing: ScreenUtil().setWidth(30),
                        children: <Widget>[
                          _toolWidget(
                              '店铺设置', Icons.insert_chart, 'store_setting'),
                          _toolWidget('套餐管理', Icons.restaurant_menu,
                              'package_management'),
                          _toolWidget('分类管理', Icons.dashboard, 'category_page'),
                          _toolWidget('菜单管理', Icons.assignment, 'menu_page'),
                          _toolWidget(
                              '银行卡', Icons.account_balance_wallet, 'bank_card'),
                          _toolWidget('联系我们', Icons.sms, 'bank_card')
                        ]),
                  )
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(80)),
            ButtonWidget(
                text: '退出登录',
                buttonBack: () {
                  print('退出登录');
                })
          ],
        ),
      ),
    );
  }

  //顶部商户信息
  _storeWidget() {
    return Container(
      height: ScreenUtil().setHeight(180),
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15)),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
                'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                height: ScreenUtil().setHeight(130),
                width: ScreenUtil().setHeight(130),
                fit: BoxFit.cover),
          ),
          SizedBox(width: ScreenUtil().setWidth(20)),
          Container(
            height: ScreenUtil().setHeight(130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '盛宴海鲜自助餐厅',
                  style: TextStyle(
                      color: Color(0xffd1b171),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '13067882143',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //金额模块
  _moneyWidget(title, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${title}',
          style: TextStyle(
              color: Color(0XFF333333),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        Text(
          '${value}',
          style: TextStyle(
              color: Color(0XFF333333),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  //工具模块
  _toolWidget(label, icon, path) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/${path}');
        },
        child: Container(
          width: ScreenUtil().setWidth(160),
          child: Column(children: <Widget>[
            Icon(icon, size: 28),
            Text(
              '${label}',
              style: TextStyle(color: Color(0xff333333), fontSize: 15),
            )
          ]),
        ));
  }
}
