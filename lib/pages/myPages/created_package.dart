import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/package_dialog.dart';

class CreatedPackage extends StatefulWidget {
  Map arguments;
  CreatedPackage({this.arguments});
  @override
  _CreatedPackageState createState() => _CreatedPackageState();
}

class _CreatedPackageState extends State<CreatedPackage> {
  String _pageType = ""; //来源页面(1:新建；2:编辑)

  //名称
  final _nameController = new TextEditingController();
  //价格
  final _priceController = new TextEditingController();
  //审核通过后是否直接上架
  bool _isShelves = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._pageType = widget.arguments['pageType'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this._nameController.dispose();
    this._priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0a0b17),
          title: Text(
            '${this._pageType == '1' ? '新建' : '编辑'}套餐',
            style: TextStyle(color: Color(0xffffffff), fontSize: 18),
          )),
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(children: <Widget>[
            Container(
                color: Color(0xffffffff),
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                height: ScreenUtil().setHeight(90),
                child: Row(children: <Widget>[
                  Text('名称',
                      style: TextStyle(color: Color(0xff333333), fontSize: 16)),
                  Expanded(
                      child: TextField(
                    controller: this._nameController,
                    style: TextStyle(color: Color(0xff333333), fontSize: 16),
                    cursorColor: Color(0xffe25d2b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '套餐名称，30字以内...',
                      hintStyle: TextStyle(fontSize: 16),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                    ),
                  ))
                ])),
            Divider(height: 1),
            Container(
                color: Color(0xffffffff),
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                height: ScreenUtil().setHeight(90),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('内容',
                          style: TextStyle(
                              color: Color(0xff333333), fontSize: 16)),
                      InkWell(
                        onTap: () {
                          showDialog<Null>(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: DialogWidget(),
                              );
                            },
                          ).then((val) {
                            print(val);
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffe25d2b),
                              borderRadius: BorderRadius.circular(13)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.control_point,
                                  color: Color(0xffffffff), size: 18),
                              SizedBox(width: 3),
                              Text(
                                '添加',
                                style: TextStyle(
                                    color: Color(0xffffffff), fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      )
                    ])),
            Divider(height: 1),
            Container(
                color: Color(0xffffffff),
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                height: ScreenUtil().setHeight(90),
                child: Row(children: <Widget>[
                  Text('价格',
                      style: TextStyle(color: Color(0xff333333), fontSize: 16)),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Text('¥',
                      style: TextStyle(color: Color(0xffe25d2b), fontSize: 16)),
                  Expanded(
                      child: TextField(
                    controller: this._priceController,
                    style: TextStyle(color: Color(0xff333333), fontSize: 16),
                    cursorColor: Color(0xffe25d2b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '输入用户购买的价格',
                      hintStyle: TextStyle(fontSize: 16),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                    ),
                  ))
                ])),
            Divider(height: 1),
            Container(
                color: Color(0xffffffff),
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                height: ScreenUtil().setHeight(90),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('审核通过后直接上架',
                          style: TextStyle(
                              color: Color(0xff333333), fontSize: 16)),
                      Switch(
                          value: this._isShelves,
                          activeColor: Color(0xffe25d2b),
                          onChanged: (value) {
                            this.setState(() {
                              _isShelves = value;
                            });
                          })
                    ])),
          ])),
    );
  }
}
