import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../service/picker_tool.dart';

class BusinessHours extends StatefulWidget {
  @override
  _BusinessHoursState createState() => _BusinessHoursState();
}

class _BusinessHoursState extends State<BusinessHours> {
  //所有营业日列表
  List _dayList = [
    {'id': '1', 'name': '每天'},
    {'id': '2', 'name': '工作日（周一至周五）'},
    {'id': '3', 'name': '法定节假日'}
  ];
  //默认选中的营业日
  String _selectId = "";
  int _selectIndex;
  String _statusName = "";

  @override
  void initState() {
    super.initState();
    //处理营业日
    this.setState(() {
      this._selectId = '1';
      for (var i = 0; i < this._dayList.length; i++) {
        if (this._dayList[i]['id'] == this._selectId) {
          _selectIndex = i;
          _statusName = this._dayList[i]['name'];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0a0b17),
          title: Text('设置营业时间',
              style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(90),
              padding: EdgeInsets.symmetric(horizontal:ScreenUtil().setWidth(20)),
              color: Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('每周营业日',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () {
                      List _nameList = [];
                      for (var i = 0; i < this._dayList.length; i++) {
                        _nameList.add(this._dayList[i]['name']);
                      }
                      JhPickerTool.showStringPicker(context, data: _nameList,
                          clickCallBack: (int index, var str) {
                        this.setState(() {
                          _selectId = this._dayList[index]['id'];
                          _selectIndex = index;
                          _statusName = this._dayList[index]['name'];
                        });
                      }, normalIndex: this._selectIndex);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${this._statusName}',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff8a8a8a))),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Color(0xff8a8a8a))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
