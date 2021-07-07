import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../widgets/button_widget.dart';

import '../service/config_tool.dart';

class LoginRegis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: RhColors.colorAppBar,
          brightness: Brightness.dark,
          title: Text('签约/登录',
              style: TextStyle(
                  color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(80),
                  horizontal: ScreenUtil().setHeight(30)),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Image.network(
                      'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(360),
                      fit: BoxFit.cover),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  ButtonWidget(
                      text: '新商户签约',
                      buttonBack: () {
                        Map arg = {'pageType': '1'};
                        Navigator.pushNamed(context, '/login', arguments: arg);
                      }),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  InkWell(
                    onTap: () {
                      Map arg = {'pageType': '2'};
                      Navigator.pushNamed(context, '/login', arguments: arg);
                    },
                    child: Container(
                        width: ScreenUtil().setWidth(680),
                        height: ScreenUtil().setHeight(80),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(40)),
                            border: Border.all(color: RhColors.colorPrimary)),
                        child: Text(
                          '商户登录',
                          style: TextStyle(
                              color: RhColors.colorPrimary,
                              fontSize: RhFontSize.fontSize16),
                        )),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  Row(
                    children: <Widget>[
                      Text(
                        '热乎优选商家版',
                        style: TextStyle(
                            fontSize: RhFontSize.fontSize16,
                            color: RhColors.colorTitle,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text(
                    '「热乎优选商家版」是本地美食推荐平台‘热乎优选’的商家端系统，功能包括订单管理、用户评价管理、财务管理、商品管理等主要功能，实现一站式服务，产品具有操作简单，功能全面，体验流畅等特色',
                    style: TextStyle(
                        fontSize: RhFontSize.fontSize12,
                        color: RhColors.colorDesc),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text(
                    '签约流程：手机号注册 -> 商户信息验证 -> 法人身份信息验证 -> 超级管理员信息验证 -> 超级管理员签约 ->完成注册',
                    style: TextStyle(
                        fontSize: RhFontSize.fontSize12,
                        color: RhColors.colorDesc),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text(
                    '签约需准备材料：管理员手机号（用于登录系统）、常用联系人信息、法人身份证、店铺营业执照、店铺食品经营许可证',
                    style: TextStyle(
                        fontSize: RhFontSize.fontSize12,
                        color: RhColors.colorDesc),
                  )
                ],
              )),
        ));
  }
}
