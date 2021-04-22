import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/package_dialog.dart';
import '../../service/picker_tool.dart';

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
  //套餐内容列表
  List _packageList = [];
  //价格
  final _priceController = new TextEditingController();
  //审核通过后是否直接上架
  bool _isShelves = true;
  //合计总价
  int _totalPrice = 0;

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
      body: SingleChildScrollView(
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(children: <Widget>[
                //名称
                Container(
                    color: Color(0xffffffff),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15)),
                    height: ScreenUtil().setHeight(90),
                    child: Row(children: <Widget>[
                      Text('名称',
                          style: TextStyle(
                              color: Color(0xff333333), fontSize: 16)),
                      Expanded(
                          child: TextField(
                        controller: this._nameController,
                        style:
                            TextStyle(color: Color(0xff333333), fontSize: 16),
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
                //图片
                SingleChildScrollView(
                  child: Container(
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                height: ScreenUtil().setHeight(90),
                                alignment: Alignment.centerLeft,
                                child: Text('图片',
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 16))),
                            SizedBox(width: ScreenUtil().setWidth(15)),
                            Expanded(
                                child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                  SizedBox(height: ScreenUtil().setHeight(25)),
                                  Wrap(
                                    spacing:ScreenUtil().setWidth(15),
                                    runSpacing:ScreenUtil().setWidth(15),
                                    children: <Widget>[
                                      _upLoadWidget(),
                                      _upLoadWidget(),
                                      _upLoadWidget(),
                                      _upLoadWidget(),
                                      _upLoadWidget(),
                                      _upLoadWidget(),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(15)),
                                  Text('*最多5张，建议图片比例1:1.3',
                                      style: TextStyle(
                                          color: Color(0xffe25d2b),
                                          fontSize: 12)),
                                  Text('默认第一张为封面图，长按可切换或删除',
                                      style: TextStyle(
                                          color: Color(0xffe25d2b),
                                          fontSize: 12)),
                                  SizedBox(height: ScreenUtil().setHeight(15))
                                ])))
                          ])),
                ),
                Divider(height: 1),
                // 内容
                SingleChildScrollView(
                  child: Container(
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                height: ScreenUtil().setHeight(90),
                                alignment: Alignment.centerLeft,
                                child: Text('内容',
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 16))),
                            SizedBox(width: ScreenUtil().setWidth(15)),
                            Expanded(
                                child: Container(
                                    child: Column(children: <Widget>[
                              _addCateWidget(),
                              _cateBox(),
                              if (this._packageList.length > 0)
                                SizedBox(height: ScreenUtil().setHeight(15))
                            ])))
                          ])),
                ),
                Divider(height: 1),
                // 价格
                Container(
                    color: Color(0xffffffff),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15)),
                    height: ScreenUtil().setHeight(90),
                    child: Row(children: <Widget>[
                      Text('价格',
                          style: TextStyle(
                              color: Color(0xff333333), fontSize: 16)),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),
                      Text('¥',
                          style: TextStyle(
                              color: Color(0xffe25d2b), fontSize: 16)),
                      Expanded(
                          child: TextField(
                        controller: this._priceController,
                        style:
                            TextStyle(color: Color(0xff333333), fontSize: 16),
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
                // 审核后直接上架
                Container(
                    color: Color(0xffffffff),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15)),
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
              ]))),
    );
  }

  //点击添加分类
  _addCateWidget() {
    return Container(
      alignment: Alignment.centerRight,
      height: ScreenUtil().setHeight(90),
      child: InkWell(
        onTap: () {
          showDialog<Null>(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: DialogWidget(dialogCallBack: (res) {
                  //点击弹框确认
                  if (res['type'] == 'confirm') {
                    this.setState(() {
                      _packageList.add(res);
                    });
                  }
                  Navigator.of(context).pop();
                }),
              );
            },
          ).then((val) {
            print('弹框关闭');
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
              Icon(Icons.control_point, color: Color(0xffffffff), size: 18),
              SizedBox(width: 3),
              Text(
                '添加',
                style: TextStyle(color: Color(0xffffffff), fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }

  //已填写的分类和菜品的框
  _cateBox() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
        color: Color(0xffF1F6F9),
        child: Column(children: <Widget>[
          Column(
              children: this
                  ._packageList
                  .asMap()
                  .keys
                  .map<Widget>((i) => this._cateMenuItem(i))
                  .toList()),
          if (this._packageList.length > 0) this._totalPriceWidget()
        ]));
  }

  //某一个分类和商品
  _cateMenuItem(i) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: ScreenUtil().setHeight(68),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      this._packageList[i]['isMulti']
                          ? '${this._packageList[i]['cateName']}（${this._packageList[i]['totalNum']}选${this._packageList[i]['selectNum']}）'
                          : '${this._packageList[i]['cateName']}',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () {
                          this.setState(() {
                            this._packageList.removeAt(i);
                          });
                        },
                        child: Icon(Icons.do_not_disturb_on,
                            size: 24, color: Color(0xffd81e06)))
                  ],
                )),
            //某分类下所有菜品
            Column(
                children: this
                    ._packageList[i]['menuList']
                    .asMap()
                    .keys
                    .map<Widget>((f) => Container(
                        padding: EdgeInsetsDirectional.only(
                            bottom: ScreenUtil().setHeight(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.lens,
                                    color: Color(0xff8a8a8a), size: 10),
                                SizedBox(width: ScreenUtil().setWidth(10)),
                                Text(
                                  '山城三味锅',
                                  style: TextStyle(
                                      color: Color(0xff8a8a8a), fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.remove_circle_outline,
                                    color: Color(0xffe25d2b), size: 20),
                                SizedBox(width: ScreenUtil().setWidth(6)),
                                Text(
                                  '1份',
                                  style: TextStyle(
                                      color: Color(0xff8a8a8a), fontSize: 14),
                                ),
                                SizedBox(width: ScreenUtil().setWidth(6)),
                                Icon(Icons.add_circle,
                                    color: Color(0xffe25d2b), size: 20)
                              ],
                            )
                          ],
                        )))
                    .toList()),
            InkWell(
                onTap: () {
                  var bb = [
                    ["11", "22"],
                    ["33", "44"]
                  ];
                  JhPickerTool.showArrayPicker(context, data: bb,
                      clickCallBack: (var index, var strData) {
                    print(index);
                    print(strData);
                  });
                },
                child: Text('+添加菜品',
                    style: TextStyle(color: Color(0xffe25d2b), fontSize: 14)))
          ]),
    );
  }

  //合计组件
  _totalPriceWidget() {
    return Container(
        height: ScreenUtil().setHeight(68),
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '合计：¥',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: '${_totalPrice}',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  //上传图片
  _upLoadWidget() {
    return Container(
      color: Color(0xffF1F6F9),
      width: ScreenUtil().setWidth(195),
      height: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.camera_alt, color: Color(0xff8a8a8a), size: 24),
            Text(
              '套餐图片',
              style: TextStyle(color: Color(0xff8a8a8a), fontSize: 14),
            )
          ]),
    );
  }
}
