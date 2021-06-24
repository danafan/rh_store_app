import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../service/picker_tool.dart';
import '../service/toast_tool.dart';
import '../service/config_tool.dart';

import '../widgets/dialog_widget.dart';
import '../widgets/order_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //未读消息数
  int _unRead = 6;
  //当前时间
  var now = new DateTime.now();
  // 当前选中的筛选条件（1:今日；2:近7日；3:近30日；4:自定义）
  String _typeIndex = "1";
  //开始时间
  String _starTime = '';
  String _endTime = '';
  //核销码控制器
  final _codeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this._starTime = '${now.year.toString()}-${now.month.toString()}-01';
    this._endTime =
        '${now.year.toString()}-${now.month.toString()}-${now.day.toString()}';
  }

  @override
  void dispose() {
    this._codeController.dispose();
    super.dispose();
  }

  //切换筛选条件
  _checkType(type) {
    this.setState(() {
      _typeIndex = type;
    });
  }

  //判断开始时间是否大于结束时间
  _judgeTime(timeType, date) {
    List _dateList = date.split('-');
    List _starTimeArr = this._starTime.split('-');
    List _endTimeArr = this._endTime.split('-');
    var _startDate;
    var _endDate;
    if (timeType == '1') {
      _startDate = new DateTime(int.parse(_dateList[0]),
          int.parse(_dateList[1]), int.parse(_dateList[2]));
      _endDate = new DateTime(int.parse(_endTimeArr[0]),
          int.parse(_endTimeArr[1]), int.parse(_endTimeArr[2]));
    } else {
      _startDate = new DateTime(int.parse(_starTimeArr[0]),
          int.parse(_starTimeArr[1]), int.parse(_starTimeArr[2]));
      _endDate = new DateTime(int.parse(_dateList[0]), int.parse(_dateList[1]),
          int.parse(_dateList[2]));
    }
    if (_startDate.isBefore(_endDate) ||
        _startDate.isAtSameMomentAs(_endDate)) {
      if (timeType == '1') {
        this.setState(() {
          _starTime = date;
        });
      } else {
        this.setState(() {
          _endTime = date;
        });
      }
      //根据当前时间区间获取数据
      _getData();
    } else {
      ToastTool.toastWidget(context, msg: '开始时间不能大于结束时间');
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
              Size(ScreenUtil().setWidth(750), ScreenUtil().setHeight(280)),
          child: AppBar(
            backgroundColor: RhColors.colorAppBar,
            brightness: Brightness.dark,
            title: Text('盛宴海鲜自助餐厅',
                style: TextStyle(
                    color: Color(0xffd1b171),
                    fontSize: RhFontSize.fontSize18,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
            centerTitle: false,
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/message_page');
                },
                child: Container(
                  width: 56,
                  child: Stack(children: <Widget>[
                    Positioned(
                        right: 14,
                        top: 14,
                        child: Icon(Icons.mail_outline, size: 24)),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: Offstage(
                            offstage: this._unRead == 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Container(
                                alignment: Alignment.center,
                                color: RhColors.colorPrimary,
                                width: 14,
                                height: 14,
                                child: Text(
                                  this._unRead > 100
                                      ? '...'
                                      : '${this._unRead}',
                                  style: TextStyle(
                                      color: RhColors.colorWhite, fontSize: 9),
                                ),
                              ),
                            )))
                  ]),
                ),
              ),
            ],
            flexibleSpace: Column(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top + 56),
              //核销模块
              _checkWidget(),
            ]),
          )),
      body: SingleChildScrollView(
          child: Column(
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
                            _dataItem(context, '预计到账', '722.12'),
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
                                  color: RhColors.colorLine,
                                ),
                                left: BorderSide(
                                  color: RhColors.colorLine,
                                ),
                                right: BorderSide(
                                  color: RhColors.colorLine,
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

//扫码、输码核销
  _checkWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/qr_code_scanner');
                },
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Icon(Icons.center_focus_weak,
                      color: RhColors.colorWhite, size: 36),
                  SizedBox(height: ScreenUtil().setHeight(8)),
                  Text('扫码核销',
                      style: TextStyle(
                          color: RhColors.colorWhite,
                          fontSize: RhFontSize.fontSize16))
                ])),
            InkWell(
              onTap: () {
                showDialog<Null>(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: DialogWidget(
                          title: '输码核销',
                          content_widget: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(30)),
                            child: Container(
                                child: TextField(
                              controller: this._codeController,
                              style: TextStyle(
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize16),
                              cursorColor: RhColors.colorDesc,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: '请输入订单编码',
                                hintStyle:
                                    TextStyle(fontSize: RhFontSize.fontSize16),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: RhColors.colorDesc, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: RhColors.colorDesc, width: 1)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(15)),
                              ),
                            )),
                          ),
                          cancel_fun: () {
                            this.setState(() {
                              _codeController.text = "";
                            });
                          },
                          confirm_fun: () {
                            if (this._codeController.text == '') {
                              ToastTool.toastWidget(context, msg: '请输入订单核销码');
                            } else {
                              this.setState(() {
                                _codeController.text = "";
                              });
                              Navigator.of(context).pop();
                              this.showResult('data');
                            }
                          },
                          confim_text: '立即查找'),
                    );
                  },
                ).then((val) {});
              },
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Icon(Icons.dialpad, color: RhColors.colorWhite, size: 30),
                SizedBox(height: ScreenUtil().setHeight(8)),
                Text('输码核销',
                    style: TextStyle(
                        color: RhColors.colorWhite,
                        fontSize: RhFontSize.fontSize16))
              ]),
            )
          ])),
    );
  }

//显示查找结果
  showResult(value) {
    Map dataMap = {'name': 'value'};
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: DialogWidget(
              title: '订单详情',
              content_widget: OrderDetail(data: dataMap),
              cancel_fun: () {},
              confirm_fun: () {
                ToastTool.toastWidget(context, msg: '订单已核销!');
                Navigator.of(context).pop();
              },
              confim_text: '立即核销'),
        );
      },
    ).then((val) {});
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
                  ? RhColors.colorPrimary
                  : RhColors.colorLine,
              borderRadius: BorderRadius.circular(3)),
          width: ScreenUtil().setWidth(136),
          height: ScreenUtil().setHeight(52),
          alignment: Alignment.center,
          child: Text(text,
              style: TextStyle(
                  color: type == this._typeIndex
                      ? RhColors.colorWhite
                      : RhColors.colorTitle,
                  fontSize: RhFontSize.fontSize14)),
        ));
  }

//自定义时间弹框
  _customTime(context) {
    return Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(60),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    JhPickerTool.showDatePicker(context,
                        dateType: DateType.YMD,
                        minValue: DateTime(2020, 08, 01),
                        maxValue: DateTime(now.year, now.month, now.day),
                        clickCallback: (var str, var time) {
                      _judgeTime('1', str);
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text('${this._starTime}',
                          style: TextStyle(
                              color: RhColors.colorTitle,
                              fontSize: RhFontSize.fontSize14)),
                      Icon(Icons.keyboard_arrow_down, size: 16)
                    ],
                  )),
              Text('至',
                  style: TextStyle(
                      color: RhColors.colorTitle,
                      fontSize: RhFontSize.fontSize14)),
              InkWell(
                  onTap: () {
                    JhPickerTool.showDatePicker(context,
                        dateType: DateType.YMD,
                        minValue: DateTime(2020, 08, 01),
                        maxValue: DateTime(now.year, now.month, now.day),
                        clickCallback: (var str, var time) {
                      _judgeTime('2', str);
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text('${this._endTime}',
                          style: TextStyle(
                              color: RhColors.colorTitle,
                              fontSize: RhFontSize.fontSize14)),
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
              Text(title,
                  style: TextStyle(
                      color: RhColors.colorTitle,
                      fontSize: RhFontSize.fontSize16,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: ScreenUtil().setHeight(6)),
              Text(desc,
                  style: TextStyle(
                      color: RhColors.colorDesc,
                      fontSize: RhFontSize.fontSize14)),
            ]));
  }

// 经营数据每一个块
  _dataItem(context, label, val) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                  color: RhColors.colorTitle,
                  fontSize: RhFontSize.fontSize14,
                  fontWeight: FontWeight.bold)),
          Text(val,
              style: TextStyle(
                  color: RhColors.colorPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
        ]);
  }

//商品分析表头
  _tableHeader() {
    return Container(
        color: RhColors.colorLine,
        height: ScreenUtil().setHeight(56),
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
                  child: Text('商品名称',
                      style: TextStyle(
                          color: RhColors.colorTitle,
                          fontSize: RhFontSize.fontSize14,
                          fontWeight: FontWeight.bold)))),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(180),
            child: Text('销量(单)',
                style: TextStyle(
                    color: RhColors.colorTitle,
                    fontSize: RhFontSize.fontSize14,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(180),
            child: Text('销售额(元)',
                style: TextStyle(
                    color: RhColors.colorTitle,
                    fontSize: RhFontSize.fontSize14,
                    fontWeight: FontWeight.bold)),
          )
        ]));
  }

//商品分析列表的每一项
  _tableItem(goodsName, number, money) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: RhColors.colorLine))),
        constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(86)),
        alignment: Alignment.center,
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
                  child: Text(goodsName,
                      style: TextStyle(
                          color: RhColors.colorTitle,
                          fontSize: RhFontSize.fontSize14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1))),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(180),
            child: Text(number,
                style: TextStyle(
                    color: RhColors.colorTitle,
                    fontSize: RhFontSize.fontSize14)),
          ),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(180),
            child: Text(money,
                style: TextStyle(
                    color: RhColors.colorTitle,
                    fontSize: RhFontSize.fontSize14)),
          )
        ]));
  }
}
