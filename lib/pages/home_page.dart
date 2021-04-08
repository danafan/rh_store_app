import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //当前时间
  var now = new DateTime.now();
  // 当前选中的筛选条件（1:今日；2:近7日；3:近30日；4:自定义）
  String _typeIndex = "1";
  //开始时间
  String _starTime = '';
  String _endTime = '';

  @override
  void initState() {
    super.initState();
    this._starTime = '${now.year.toString()}-${now.month.toString()}-01';
    this._endTime =
        '${now.year.toString()}-${now.month.toString()}-${now.day.toString()}';
  }

  //切换筛选条件
  _checkType(type) {
    this.setState(() {
      _typeIndex = type;
    });
  }

  //判断开始时间是否大于结束时间
  _judgeTime(timeType, date) {
    List _starTimeArr = this._starTime.split('-');
    List _endTimeArr = this._endTime.split('-');
    var _startDate;
    var _endDate;
    if (timeType == '1') {
      _startDate = new DateTime(date.year, date.month, date.day);
      _endDate = new DateTime(int.parse(_endTimeArr[0]),
          int.parse(_endTimeArr[1]), int.parse(_endTimeArr[2]));
    } else {
      _startDate = new DateTime(int.parse(_starTimeArr[0]),
          int.parse(_starTimeArr[1]), int.parse(_starTimeArr[2]));
      _endDate = new DateTime(date.year, date.month, date.day);
    }
    if (_startDate.isBefore(_endDate) ||
        _startDate.isAtSameMomentAs(_endDate)) {
      String _currentTime =
          '${date.year.toString()}-${date.month.toString()}-${date.day.toString()}';
      if (timeType == '1') {
        this.setState(() {
          _starTime = _currentTime;
        });
      } else {
        this.setState(() {
          _endTime = _currentTime;
        });
      }
      //根据当前时间区间获取数据
      _getData();
    } else {
      print('时间不符合');
    }
  }

  //根据当前时间区间获取数据
  _getData() {
    print(this._starTime);
    print(this._endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size(ScreenUtil().setWidth(750), ScreenUtil().setHeight(360)),
          child: AppBar(
            backgroundColor: Color(0xff0a0b17),
            brightness: Brightness.dark,
            flexibleSpace: Column(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top),
              _storeInfo(),
              //扫码核销
              _checkWidget(),
              // 公告
              _messageWidget(context),
            ]),
          )),
      body: Container(
          child: ListView(
        children: <Widget>[
          // 商品报告
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(15),
                    right: ScreenUtil().setWidth(15),
                    bottom: ScreenUtil().setHeight(25)),
                child: Column(
                  children: <Widget>[
                    //时间选项
                    _timeTab(),
                    //自定义时间弹框
                    this._typeIndex == '4'
                        ? _customTime(context)
                        : Divider(height: 0),
                    Divider(height: 1),
                    //内容头部
                    _contentTitle('经营数据', '实际到账 = 核销金额 * 90%'),
                    // 内容行
                    Container(
                      height: ScreenUtil().setHeight(100),
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _dataItem(context, '实际到账', '805.23'),
                            _dataItem(context, '核销金额', '1200.24'),
                            _dataItem(context, '核销数量', '8')
                          ]),
                    ),
                    // 内容行
                    Container(
                      height: ScreenUtil().setHeight(100),
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _dataItem(context, '预计收益', '722.12'),
                            _dataItem(context, '下单金额', '965.20'),
                            _dataItem(context, '下单数量', '3')
                          ]),
                    ),
                    Divider(height: 1),
                    //内容头部
                    _contentTitle('商品分析', '按上架套餐销量从高到低排序'),
                    //套餐表格
                    Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                  color: Color(0xffEDF0F7),
                                ),
                                left: BorderSide(
                                  color: Color(0xffEDF0F7),
                                ),
                                right: BorderSide(
                                  color: Color(0xffEDF0F7),
                                ))),
                        child: Column(children: <Widget>[
                          //表头
                          _tableHeader(),
                          //每一行
                          _tableItem('老坛酸菜鱼套餐老坛酸菜鱼套餐', '12', '1242.24'),
                          _tableItem('老坛酸菜鱼套餐', '12', '1242.24'),
                          _tableItem('老坛酸菜鱼套餐', '12', '1242.24'),
                          _tableItem('老坛酸菜鱼套餐', '12', '1242.24'),
                          _tableItem('老坛酸菜鱼套餐', '12', '1242.24'),
                        ]))
                  ],
                )),
          )
        ],
      )),
    );
  }

//商家信息
  _storeInfo() {
    return Container(
        height: ScreenUtil().setHeight(60),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15)),
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Text('盛宴海鲜自助餐厅',
                  style: TextStyle(
                      color: Color(0xffd1b171),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1)),
          SizedBox(width: ScreenUtil().setWidth(30)),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xffdcf6ef),
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setHeight(15)))),
            height: ScreenUtil().setHeight(30),
            width: ScreenUtil().setWidth(118),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Color(0xff47af5d),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setHeight(8)))),
                    height: ScreenUtil().setHeight(16),
                    width: ScreenUtil().setHeight(16)),
                Text(
                  '营业中',
                  style: TextStyle(fontSize: 11, color: Color(0xff333333)),
                )
              ],
            ),
          )
        ]));
  }

//扫码、输码核销
  _checkWidget() {
    return Container(
      height: ScreenUtil().setHeight(220),
      child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Icon(Icons.center_focus_weak, color: Colors.white, size: 36),
              SizedBox(height: ScreenUtil().setHeight(8)),
              Text('扫码核销', style: TextStyle(color: Colors.white, fontSize: 16))
            ]),
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Icon(Icons.dialpad, color: Colors.white, size: 30),
              SizedBox(height: ScreenUtil().setHeight(8)),
              Text('输码核销', style: TextStyle(color: Colors.white, fontSize: 16))
            ])
          ])),
    );
  }

//公告
  _messageWidget(context) {
    return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15)),
        child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.volume_up,
                    size: 22, color: Theme.of(context).primaryColor),
                SizedBox(width: ScreenUtil().setWidth(8)),
                Expanded(
                    flex: 1,
                    child: Text(
                      '我说你小子是学好难，学坏不用教啊，不知道就算了，知道了可不行',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Color(0xff333333), fontSize: 14),
                    )),
                SizedBox(width: ScreenUtil().setWidth(8)),
                Icon(Icons.arrow_forward_ios, size: 16)
              ]),
        ));
  }

//时间选项
  _timeTab() {
    return Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(100),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _filterButton(context, '今日', '1'),
              _filterButton(context, '近7日', '2'),
              _filterButton(context, '近30日', '3'),
              _filterButton(context, '自定义', '4'),
            ]));
  }

// 每一个选项按钮
  _filterButton(context, text, type) {
    return InkWell(
        onTap: () {
          this._checkType(type);
        },
        child: Container(
          decoration: BoxDecoration(
              color: type == this._typeIndex
                  ? Theme.of(context).primaryColor
                  : Color(0xffEDF0F7),
              borderRadius: BorderRadius.circular(3)),
          width: ScreenUtil().setWidth(136),
          height: ScreenUtil().setHeight(52),
          alignment: Alignment.center,
          child: Text('${text}',
              style: TextStyle(
                  color: type == this._typeIndex
                      ? Colors.white
                      : Color(0xff333333),
                  fontSize: 15)),
        ));
  }

//自定义时间弹框
  _customTime(context) {
    return Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(60),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
            Widget>[
          InkWell(
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(this.now.year, 1, 1),
                    maxTime:
                        DateTime(this.now.year, this.now.month, this.now.day),
                    onConfirm: (date) {
                  _judgeTime('1', date);
                }, currentTime: DateTime.now(), locale: LocaleType.zh);
              },
              child: Row(
                children: <Widget>[
                  Text('${this._starTime}',
                      style: TextStyle(color: Color(0xff333333), fontSize: 15)),
                  Icon(Icons.keyboard_arrow_down, size: 16)
                ],
              )),
          Text('至', style: TextStyle(color: Color(0xff333333), fontSize: 15)),
          InkWell(
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(this.now.year, 1, 1),
                    maxTime:
                        DateTime(this.now.year, this.now.month, this.now.day),
                    onConfirm: (date) {
                  _judgeTime('2', date);
                }, currentTime: DateTime.now(), locale: LocaleType.zh);
              },
              child: Row(
                children: <Widget>[
                  Text('${this._endTime}',
                      style: TextStyle(color: Color(0xff333333), fontSize: 15)),
                  Icon(Icons.keyboard_arrow_down, size: 16)
                ],
              ))
        ]));
  }

//内容头部
  _contentTitle(title, desc) {
    return Container(
        alignment: Alignment.centerLeft,
        height: ScreenUtil().setHeight(100),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${title}',
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: ScreenUtil().setHeight(6)),
              Text('${desc}',
                  style: TextStyle(color: Color(0xff8a8a8a), fontSize: 14)),
            ]));
  }

// 经营数据每一个块
  _dataItem(context, label, val) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('${label}',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          Text('${val}',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
        ]);
  }

//商品分析表头
  _tableHeader() {
    return Container(
        color: Color(0xffF3F6F5),
        height: ScreenUtil().setHeight(56),
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
                  child: Text('商品名称',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)))),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(180),
            child: Text('销量(单)',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(180),
            child: Text('销售额(元)',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          )
        ]));
  }

//商品分析列表的每一项
  _tableItem(goods_name, number, money) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffEDF0F7)))),
        constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(86)),
        alignment: Alignment.center,
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
                  child: Text('${goods_name}',
                      style: TextStyle(color: Color(0xff333333), fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1))),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(180),
            child: Text('${number}',
                style: TextStyle(color: Color(0xff333333), fontSize: 14)),
          ),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(180),
            child: Text('${money}',
                style: TextStyle(color: Color(0xff333333), fontSize: 14)),
          )
        ]));
  }
}
