import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../service/picker_tool.dart';
import '../../../widgets/button_widget.dart';

import '../../../service/toast_tool.dart';

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

  //营业时间段列表
  List _timeArr = [
    {'start': '00:00', 'end': '00:00'}
  ];

  //时间插件列表
  List _dataArr = [
    ['00', '01', '02', '03', '04', '05'],
    ['00', '01', '03']
  ];

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
          brightness: Brightness.dark,
          title: Text('设置营业时间',
              style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(90),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
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
                          _statusName = str;
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
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Text('设置营业时间段（最多3个）',
                  style: TextStyle(color: Color(0xff8a8a8a), fontSize: 14)),
            ),
            Container(
              color: Color(0xffffffff),
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Column(
                children: <Widget>[
                  Column(
                      children: this._timeArr.asMap().keys.map<Widget>((i) {
                    return _timeRow(i);
                  }).toList()),
                  Divider(height: 1),
                  SizedBox(height: ScreenUtil().setWidth(20)),
                  InkWell(
                    onTap: () {
                      if (this._timeArr.length < 3) {
                        Map _timeMap = {'start': '00:00', 'end': '00:00'};
                        this.setState(() {
                          this._timeArr.add(_timeMap);
                        });
                      } else {
                        ToastTool.toastWidget(context, msg: '最多设置3个营业时间段！');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Color(0xffe25d2b),
                          size: 16,
                        ),
                        Text(
                          '添加营业时间段',
                          style:
                              TextStyle(color: Color(0xffe25d2b), fontSize: 14),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(30)),
            ButtonWidget(
                text: '提交',
                buttonBack: () {
                  print('提交');
                })
          ],
        ));
  }

  //某一个时间段行
  _timeRow(i) {
    return Container(
      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
      width: ScreenUtil().setWidth(500),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _timeBox(this._timeArr[i]['start'], i, 'start'),
            SizedBox(width: ScreenUtil().setWidth(20)),
            Text('至', style: TextStyle(color: Color(0xff333333), fontSize: 14)),
            SizedBox(width: ScreenUtil().setWidth(20)),
            _timeBox(this._timeArr[i]['end'], i, 'end'),
            SizedBox(width: ScreenUtil().setWidth(20))
          ]),
          Offstage(
              offstage: i == 0,
              child: InkWell(
                onTap: () {
                  this.setState(() {
                    this._timeArr.removeAt(i);
                  });
                },
                child: Icon(Icons.do_not_disturb_on,
                    color: Color(0xffe25d2b), size: 22),
              ))
        ],
      ),
    );
  }

  //某一个时间段框
  _timeBox(timeStr, i, type) {
    return InkWell(
        onTap: () {
          //当前点击的左右两列的下标
          List<int> _selectIndexArr = [0, 0];
          String _leftStr = timeStr.split(':')[0];
          String _rightStr = timeStr.split(':')[1];
          for (var li = 0; li < this._dataArr[0].length; li++) {
            if (_leftStr == this._dataArr[0][li]) {
              _selectIndexArr[0] = li;
              break;
            }
          }
          for (var ri = 0; ri < this._dataArr[0].length; ri++) {
            if (_rightStr == this._dataArr[1][ri]) {
              _selectIndexArr[1] = ri;
              break;
            }
          }
          JhPickerTool.showArrayPicker(context, data: _dataArr,
              clickCallBack: (List indexArr, var str) {
            this.setState(() {
              this._timeArr[i]['$type'] = str[0] + ':' + str[1];
            });
          }, normalIndex: _selectIndexArr);
        },
        child: Container(
          width: ScreenUtil().setWidth(160),
          height: ScreenUtil().setHeight(60),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff8a8a8a)),
              borderRadius: BorderRadius.circular(5)),
          child: Text('$timeStr',
              style: TextStyle(color: Color(0xff333333), fontSize: 16)),
        ));
  }
}
