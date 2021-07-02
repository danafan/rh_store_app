import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/button_widget.dart';

import '../../service/picker_tool.dart';
import '../../service/toast_tool.dart';
import '../../service/config_tool.dart';

class AddMenu extends StatefulWidget {
  final Map arguments;
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
    {'id': '0', 'name': '暂不分配'},
    {'id': '1', 'name': '主食'},
    {'id': '2', 'name': '凉菜'},
    {'id': '3', 'name': '凉菜'},
    {'id': '4', 'name': '凉菜'},
    {'id': '5', 'name': '凉菜'},
    {'id': '6', 'name': '凉菜'},
  ];
  //选中的分类id
  int _activeCateIndex = 0;

  @override
  void initState() {
    super.initState();
    this.setState(() {
      this._pageType = widget.arguments['pageType'];
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._nameController.dispose();
    this._priceController.dispose();
    this._unitController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: RhColors.colorAppBar,
            brightness: Brightness.dark,
            title: Text(
              '${this._pageType == '1' ? '添加' : '编辑'}菜品',
              style: TextStyle(
                  color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18),
            )),
        body: SingleChildScrollView(
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // 触摸收起键盘
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                    color: RhColors.colorWhite,
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15)),
                    child: Column(children: <Widget>[
                      //名称
                      Container(
                          height: ScreenUtil().setHeight(90),
                          child: Row(children: <Widget>[
                            _labelTitle('菜品名称'),
                            Expanded(
                                child: TextField(
                              controller: this._nameController,
                              style: TextStyle(
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize16),
                              cursorColor: RhColors.colorPrimary,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: '30字以内...',
                                hintStyle:
                                    TextStyle(fontSize: RhFontSize.fontSize16),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(15)),
                              ),
                            ))
                          ])),
                      Divider(height: 1),
                      //图片
                      Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            _labelTitle('图片'),
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
                                          color: RhColors.colorPrimary,
                                          fontSize: RhFontSize.fontSize12)),
                                  Text('*图片比例1:1,建议大于600*600像素',
                                      style: TextStyle(
                                          color: RhColors.colorPrimary,
                                          fontSize: RhFontSize.fontSize12)),
                                  SizedBox(height: ScreenUtil().setHeight(15))
                                ])))
                          ])),
                      Divider(height: 1),
                      // 价格
                      Container(
                          height: ScreenUtil().setHeight(90),
                          child: Row(children: <Widget>[
                            _labelTitle('价格'),
                            SizedBox(
                              width: ScreenUtil().setWidth(10),
                            ),
                            Text('¥',
                                style: TextStyle(
                                    color: RhColors.colorPrimary,
                                    fontSize: RhFontSize.fontSize16)),
                            Expanded(
                                child: TextField(
                              controller: this._priceController,
                              style: TextStyle(
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize16),
                              cursorColor: RhColors.colorPrimary,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '菜品单价',
                                hintStyle:
                                    TextStyle(fontSize: RhFontSize.fontSize16),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(15)),
                              ),
                            ))
                          ])),
                      Divider(height: 1),
                      // 单位
                      Container(
                          height: ScreenUtil().setHeight(90),
                          child: Row(children: <Widget>[
                            Text('单位',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize16,
                                    fontWeight: FontWeight.bold)),
                            Expanded(
                                child: TextField(
                              controller: this._unitController,
                              style: TextStyle(
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize16),
                              cursorColor: RhColors.colorPrimary,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: '默认【份】',
                                hintStyle:
                                    TextStyle(fontSize: RhFontSize.fontSize16),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(15)),
                              ),
                            ))
                          ])),
                      Divider(height: 1),
                      // 所属分类
                      Container(
                          height: ScreenUtil().setHeight(90),
                          child: Row(children: <Widget>[
                            Text('所属分类',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize16,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: ScreenUtil().setWidth(10),
                            ),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      List _nameList = [];
                                      for (var i = 0;
                                          i < this._cateList.length;
                                          i++) {
                                        _nameList
                                            .add(this._cateList[i]['name']);
                                      }
                                      JhPickerTool.showStringPicker(context,
                                          data: _nameList,
                                          clickCallBack: (int index, var str) {
                                        this.setState(() {
                                          _activeCateIndex = index;
                                        });
                                      }, normalIndex: this._activeCateIndex);
                                    },
                                    child: Text(
                                        '${this._cateList[this._activeCateIndex]['name']}',
                                        style: TextStyle(
                                            fontSize: RhFontSize.fontSize16,
                                            color: RhColors.colorDesc))))
                          ])),
                      SizedBox(height: ScreenUtil().setHeight(50)),
                      ButtonWidget(
                          text: '提交',
                          buttonBack: () {
                            final _moneyRegExp = new RegExp(
                                r'^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$');
                            if (this._nameController.text == '') {
                              ToastTool.toastWidget(context, msg: '请输入菜品名称');
                            } else if (this._imageList.length == 0) {
                              ToastTool.toastWidget(context, msg: '请上传菜品主图');
                            } else if (this._priceController.text == '') {
                              ToastTool.toastWidget(context, msg: '请输入购买价格');
                            } else if (!_moneyRegExp
                                .hasMatch(this._priceController.text)) {
                              ToastTool.toastWidget(context,
                                  msg: '价格需大于0且最多两位小数');
                            } else {
                              Navigator.of(context).pop();
                              print('已成功');
                            }
                          })
                    ])))));
  }

  //每一行的label
  _labelTitle(title) {
    return Container(
      height: ScreenUtil().setHeight(90),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
            text: '*',
            style: TextStyle(
                fontSize: RhFontSize.fontSize16,
                fontWeight: FontWeight.bold,
                color: RhColors.colorPrimary),
            children: <TextSpan>[
              TextSpan(
                  text: title, style: TextStyle(color: RhColors.colorTitle)),
            ]),
      ),
    );
  }

  //上传图片(组件)
  _upLoadWidget() {
    return InkWell(
        onTap: this.getImage,
        child: Container(
          margin: EdgeInsets.only(top: ScreenUtil().setWidth(15)),
          color: RhColors.colorLine,
          width: ScreenUtil().setWidth(195),
          height: ScreenUtil().setWidth(195),
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.camera_alt, color: RhColors.colorDesc, size: 24),
                Text(
                  '菜品主图',
                  style: TextStyle(color: RhColors.colorDesc, fontSize: 14),
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
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize16)))),
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
                                  color: RhColors.colorPrimary,
                                  fontSize: RhFontSize.fontSize16)))),
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
