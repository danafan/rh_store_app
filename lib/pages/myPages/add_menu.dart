import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/button_widget.dart';

class AddMenu extends StatefulWidget {
  Map arguments;
  AddMenu({this.arguments});

  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  String _pageType = ""; //来源页面(1:新建；2:编辑)
  //名称
  final _nameController = new TextEditingController();
  //选中的图片地址
  List _imageList = [];
  final picker = ImagePicker();
  //价格
  final _priceController = new TextEditingController();
  //单位
  final _unitController = new TextEditingController();
  //所有分类列表
  List _cateList = [
    {'id': '', 'name': '暂不分配'},
    {'id': '1', 'name': '主食'},
    {'id': '2', 'name': '凉菜'},
    {'id': '3', 'name': '凉菜'},
    {'id': '4', 'name': '凉菜'},
    {'id': '5', 'name': '凉菜'},
    {'id': '6', 'name': '凉菜'},
  ];
  //选中的分类id
  String _activeCateId = '';
  String _activeCateName = '暂不分配';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.setState(() {
      this._pageType = widget.arguments['pageType'];
      this._activeCateId = widget.arguments['id'];
      this._activeCateName = widget.arguments['name'];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this._nameController.dispose();
    this._priceController.dispose();
    this._unitController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff0a0b17),
            title: Text(
              '${this._pageType == '1' ? '新建' : '编辑'}菜品',
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
                        RichText(
                          text: TextSpan(
                              text: '*',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xffe25d2b)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '菜品名称',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff333333))),
                              ]),
                        ),
                        Expanded(
                            child: TextField(
                          controller: this._nameController,
                          style:
                              TextStyle(color: Color(0xff333333), fontSize: 16),
                          cursorColor: Color(0xffe25d2b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: '30字以内...',
                            hintStyle: TextStyle(fontSize: 16),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15)),
                          ),
                        ))
                      ])),
                  Divider(height: 1),
                  //图片
                  Container(
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: ScreenUtil().setHeight(90),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xffe25d2b)),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '图片',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff333333))),
                                    ]),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(15)),
                            Expanded(
                                child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                  SizedBox(height: ScreenUtil().setHeight(25)),
                                  this._imageList.length == 0
                                      ? _upLoadWidget()
                                      : _imageWidget(),
                                  SizedBox(height: ScreenUtil().setHeight(15)),
                                  Text('长按可删除',
                                      style: TextStyle(
                                          color: Color(0xffe25d2b),
                                          fontSize: 12)),
                                  Text('*图片比例1:1,建议大于600*600像素',
                                      style: TextStyle(
                                          color: Color(0xffe25d2b),
                                          fontSize: 12)),
                                  SizedBox(height: ScreenUtil().setHeight(15))
                                ])))
                          ])),
                  Divider(height: 1),
                  // 价格
                  Container(
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                      height: ScreenUtil().setHeight(90),
                      child: Row(children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: '*',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xffe25d2b)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '价格',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff333333))),
                              ]),
                        ),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '菜品单价',
                            hintStyle: TextStyle(fontSize: 16),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15)),
                          ),
                        ))
                      ])),
                  Divider(height: 1),
                  // 单位
                  Container(
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                      height: ScreenUtil().setHeight(90),
                      child: Row(children: <Widget>[
                        Text('单位',
                            style: TextStyle(
                                color: Color(0xff333333), fontSize: 16)),
                        Expanded(
                            child: TextField(
                          controller: this._unitController,
                          style:
                              TextStyle(color: Color(0xff333333), fontSize: 16),
                          cursorColor: Color(0xffe25d2b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: '默认【份】',
                            hintStyle: TextStyle(fontSize: 16),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15)),
                          ),
                        ))
                      ])),
                  Divider(height: 1),
                  // 所属分类
                  Container(
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15)),
                      height: ScreenUtil().setHeight(90),
                      child: Row(children: <Widget>[
                        Text('所属分类',
                            style: TextStyle(
                                color: Color(0xff333333), fontSize: 16)),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    enableDrag: false, //设置不能拖拽关闭
                                    builder: (BuildContext context) {
                                      return Container(
                                          height: ScreenUtil().setHeight(360),
                                          child: ListView.builder(
                                              itemCount: this._cateList.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                    onTap: () {
                                                      this.setState(() {
                                                        _activeCateId =
                                                            this._cateList[
                                                                index]['id'];
                                                        _activeCateName =
                                                            this._cateList[
                                                                index]['name'];
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: _categoryItemWidget(
                                                        this._cateList[index]));
                                              }));
                                    },
                                  );
                                },
                                child: Text('${this._activeCateName}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff8a8a8a)))))
                      ])),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  ButtonWidget(
                      text: '提交',
                      buttonBack: () {
                        final _moneyRegExp = new RegExp(
                            r'^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$');
                        if (this._nameController.text == '') {
                          print('请输入菜品名称');
                        } else if (this._imageList.length == 0) {
                          print('请上传菜品主图');
                        } else if (this._priceController.text == '') {
                          print('请输入购买价格');
                        } else if (!_moneyRegExp
                            .hasMatch(this._priceController.text)) {
                          print('价格需大于0且最多两位小数');
                        } else {
                          Navigator.of(context).pop();
                          print('已成功');
                        }
                      })
                ]))));
  }

  //每一个分类的item
  _categoryItemWidget(item) {
    return Container(
      decoration: BoxDecoration(
          color: item['id'] == this._activeCateId
              ? Color(0xffF1F6F9)
              : Color(0xffffffff),
          border: Border(bottom: BorderSide(color: Color(0xffF1F6F9)))),
      height: ScreenUtil().setHeight(90),
      width: double.infinity,
      alignment: Alignment.center,
      child: Text('${item['name']}',
          style: TextStyle(
              fontSize: 15,
              color: item['id'] == this._activeCateId
                  ? Color(0xffe25d2b)
                  : Color(0xff333333))),
    );
  }

  //上传图片(组件)
  _upLoadWidget() {
    return InkWell(
        onTap: this.getImage,
        child: Container(
          margin: EdgeInsets.only(top: ScreenUtil().setWidth(15)),
          color: Color(0xffF1F6F9),
          width: ScreenUtil().setWidth(195),
          height: ScreenUtil().setWidth(195),
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.camera_alt, color: Color(0xff8a8a8a), size: 24),
                Text(
                  '菜品主图',
                  style: TextStyle(color: Color(0xff8a8a8a), fontSize: 14),
                )
              ]),
        ));
  }

  //图片组件
  _imageWidget() {
    return GestureDetector(
      child: Image.file(
        this._imageList[0],
        width: ScreenUtil().setWidth(195),
        height: ScreenUtil().setWidth(195),
        fit: BoxFit.cover,
      ),
      onTap: () {
        var arg = {'images': this._imageList, 'index': 0, 'heroTag': '111'};
        Navigator.pushNamed(context, '/photo_view', arguments: arg);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          enableDrag: false, //设置不能拖拽关闭
          builder: (BuildContext context) {
            return Container(
              height: ScreenUtil().setHeight(160),
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        this.setState(() {
                          this._imageList.removeAt(0);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: ScreenUtil().setHeight(58),
                          alignment: Alignment.center,
                          child: Text('删除',
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: 16)))),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: ScreenUtil().setHeight(50),
                          alignment: Alignment.center,
                          child: Text('取消',
                              style: TextStyle(
                                  color: Color(0xffe25d2b), fontSize: 16)))),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //获取相册
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      this.setState(() {
        this._imageList.add(File(pickedFile.path));
      });
    } else {
      print('没有选择图片');
    }
  }
}
