import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/dialog_widget.dart';

import '../../service/picker_tool.dart';
import '../../service/toast_tool.dart';
import '../../service/config_tool.dart';

class StoreSetting extends StatefulWidget {
  @override
  _StoreSettingState createState() => _StoreSettingState();
}

class _StoreSettingState extends State<StoreSetting> {
  //选中的图片地址
  List _imageList = [];
  final picker = ImagePicker();
  //所有的状态列表
  List _statusList = [
    {'id': '1', 'name': '营业中'},
    {'id': '2', 'name': '已打烊'},
    {'id': '3', 'name': '已停业'}
  ];
  //默认选中的营业状态
  String _selectId = "";
  int _selectIndex;
  String _statusName = "";

  //输入框Controller
  final _textFieldController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    //处理营业状态
    this.setState(() {
      this._selectId = '1';
      for (var i = 0; i < this._statusList.length; i++) {
        if (this._statusList[i]['id'] == this._selectId) {
          _selectIndex = i;
          _statusName = this._statusList[i]['name'];
        }
      }
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RhColors.colorAppBar,
        brightness: Brightness.dark,
        title: Text('店铺设置',
            style: TextStyle(
                color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          _rowItem('店铺名称', true, _rowExpandWidget('盛宴海鲜自助餐厅', true)),
          _rowItem('经营品类', true, _rowExpandWidget('火锅', true)),
          _rowItem('登录名', true, _rowExpandWidget('13067882143', true)),
          _rowItem(
              '店铺主图',
              false,
              InkWell(
                onTap: () {
                  //ToastTool.toastWidget(context, msg: '本月您已修改过店铺主图，下个月再试试吧～');
                  this.getImage();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                          'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                          height: ScreenUtil().setHeight(110),
                          width: ScreenUtil().setHeight(143),
                          fit: BoxFit.cover),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Color(0xff8a8a8a))
                  ],
                ),
              )),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _rowItem(
              '营业状态',
              true,
              InkWell(
                onTap: () {
                  List _nameList = [];
                  for (var i = 0; i < this._statusList.length; i++) {
                    _nameList.add(this._statusList[i]['name']);
                  }
                  JhPickerTool.showStringPicker(context, data: _nameList,
                      clickCallBack: (int index, var str) {
                    this.setState(() {
                      _selectId = this._statusList[index]['id'];
                      _selectIndex = index;
                      _statusName = this._statusList[index]['name'];
                    });
                  }, normalIndex: this._selectIndex);
                },
                child: _rowExpandWidget(this._statusName, false),
              )),
          _rowItem(
              '店铺地址',
              false,
              InkWell(
                onTap: () {
                  // ToastTool.toastWidget(context, msg: '本月您已修改过店铺地址，下个月再试试吧～');
                  Navigator.pushNamed(context, '/map_page');
                  print('调用地图获取位置');
                },
                child: _rowExpandWidget('杭州市萧山区城厢街道127号', false),
              )),
          _rowItem(
              '营业时间',
              true,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/business_hours');
                },
                child: _rowExpandWidget('周一至周五 (7:00 - 21:00)', false),
              )),
          _rowItem(
              '联系人',
              true,
              InkWell(
                onTap: () {
                  showDialog<Null>(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: DialogWidget(
                            title: '联系人',
                            contentWidget: _contentWidget('联系人'),
                            cancelFun: () {
                              this.setState(() {
                                this._textFieldController.text = "";
                              });
                            },
                            confirmFun: () {
                              print('提交编辑联系人');
                              print(this._textFieldController.text);
                            }),
                      );
                    },
                  ).then((val) {
                    this.setState(() {
                      this._textFieldController.text = "";
                    });
                  });
                },
                child: _rowExpandWidget('彪子', false),
              )),
          _rowItem(
              '联系电话',
              true,
              InkWell(
                onTap: () {
                  showDialog<Null>(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: DialogWidget(
                            title: '联系电话',
                            contentWidget: _contentWidget('联系电话'),
                            cancelFun: () {
                              this.setState(() {
                                this._textFieldController.text = "";
                              });
                            },
                            confirmFun: () {
                              print('提交编辑联系电话');
                              print(this._textFieldController.text);
                            }),
                      );
                    },
                  ).then((val) {
                    this.setState(() {
                      this._textFieldController.text = "";
                    });
                  });
                },
                child: _rowExpandWidget('13067882143', false),
              )),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _rowItem(
              '营业资质',
              true,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/business_info');
                  print('营业资质');
                },
                child: _rowExpandWidget('', false),
              )),
        ],
      )),
    );
  }

  //每一行
  _rowItem(title, isOnly, _widget) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
      decoration: BoxDecoration(
          color: RhColors.colorWhite,
          border: Border(bottom: BorderSide(color: RhColors.colorLine))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(220),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: RhColors.colorTitle,
                          fontSize: RhFontSize.fontSize14,
                          fontWeight: FontWeight.bold)),
                  Offstage(
                      offstage: isOnly,
                      child: Text('*每月允许修改一次',
                          style: TextStyle(
                              color: RhColors.colorPrimary,
                              fontSize: RhFontSize.fontSize12)))
                ]),
          ),
          Expanded(child: _widget)
        ],
      ),
    );
  }

  //每一行后半部分
  _rowExpandWidget(text, offstage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          child: Text(text,
              style: TextStyle(
                  fontSize: RhFontSize.fontSize14, color: RhColors.colorTitle),
              overflow: TextOverflow.ellipsis),
        )),
        SizedBox(width: ScreenUtil().setWidth(8)),
        Offstage(
            offstage: offstage,
            child: Icon(Icons.arrow_forward_ios,
                size: RhFontSize.fontSize16, color: RhColors.colorDesc))
      ],
    );
  }

  //获取相册
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      this.setState(() {
        this._imageList.add(File(pickedFile.path));
      });
      print(this._imageList);
    } else {
      ToastTool.toastWidget(context, msg: '没有选择图片');
    }
  }

  //联系人、联系电话弹框
  _contentWidget(hintText) {
    return Container(
        constraints: BoxConstraints(maxHeight: ScreenUtil().setHeight(60)),
        child: TextField(
          controller: this._textFieldController,
          style: TextStyle(color: RhColors.colorTitle, fontSize: RhFontSize.fontSize14),
          cursorColor: RhColors.colorTitle,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: RhFontSize.fontSize16),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: RhColors.colorDesc, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: RhColors.colorDesc, width: 1)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
          ),
        ));
  }
}
