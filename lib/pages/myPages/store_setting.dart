import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';

import '../../service/picker_tool.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0a0b17),
        title: Text('店铺设置',
            style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
      ),
      body: Column(
        children: <Widget>[
          _rowItem(
              '店铺名称',
              true,
              Text('盛宴海鲜自助餐厅',
                  style: TextStyle(color: Color(0xff333333), fontSize: 14))),
          _rowItem(
              '经营品类',
              true,
              Text('火锅',
                  style: TextStyle(color: Color(0xff333333), fontSize: 14))),
          _rowItem(
              '店铺主图',
              false,
              InkWell(
                onTap: () {
                  this.getImage();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${this._statusName}'),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Color(0xff8a8a8a))
                  ],
                ),
              )),
          _rowItem(
              '店铺地址',
              false,
              InkWell(
                onTap: () {
                  print('调用地图获取位置');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('杭州市萧山区城厢街道127号'),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Color(0xff8a8a8a))
                  ],
                ),
              )),
          _rowItem(
              '营业时间',
              true,
              InkWell(
                onTap: () {
                  print('营业时间');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('7:00 - 19:00'),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Color(0xff8a8a8a))
                  ],
                ),
              )),
          _rowItem(
              '联系人',
              true,
              InkWell(
                onTap: () {
                  print('联系人');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('彪子'),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Color(0xff8a8a8a))
                  ],
                ),
              )),
          _rowItem(
              '联系电话',
              true,
              InkWell(
                onTap: () {
                  print('联系电话');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('13067828143'),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Color(0xff8a8a8a))
                  ],
                ),
              )),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _rowItem(
              '营业资质',
              true,
              InkWell(
                onTap: () {
                  print('营业资质');
                },
                child: Icon(Icons.arrow_forward_ios,
                    size: 16, color: Color(0xff8a8a8a)),
              )),
        ],
      ),
    );
  }

  //每一行
  _rowItem(title, is_only, _widget) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border(bottom: BorderSide(color: Color(0xffF1F6F9)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${title}',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Offstage(
                      offstage: is_only,
                      child: Text('*每月允许修改一次',
                          style: TextStyle(
                              color: Color(0xffe25d2b), fontSize: 12)))
                ]),
          ),
          _widget
        ],
      ),
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
      print('没有选择图片');
    }
  }
}
