import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import 'package:rh_store_app/widgets/list_bottom.dart';
import 'package:rh_store_app/widgets/loading_more.dart';

import '../../service/picker_tool.dart';
import '../../service/config_tool.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  //当前时间
  var now = new DateTime.now();
  //选中的当前月份
  String _currentMonth = "";
  //账单列表
  List<Map> _commentList = [];
  //是否加载中
  bool _isLoad = false;
  //是否加载了全部
  bool _isOver = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    //获取评论列表
    _loadMoreData();
    //监听列表滚动
    this._scrollController.addListener(() {
      // 滑动到底部的关键判断
      if (!this._isLoad &&
          this._scrollController.position.pixels >=
              this._scrollController.position.maxScrollExtent) {
        if (this._commentList.length >= 30) {
          //如果所有数据加载完毕
          setState(() {
            this._isOver = true;
          });
        } else {
          // 开始加载数据
          setState(() {
            this._isLoad = true;
            //加载更多数据
            this._loadMoreData();
          });
        }
      }
    });
    //设置当前选中月
    this._currentMonth = now.year.toString() +
        '-' +
        (now.month < 10 ? '0' + now.month.toString() : now.month.toString());
  }

  //加载更多数据
  Future _loadMoreData() {
    return Future.delayed(Duration(seconds: 1), () {
      List<Map> newsList = [
        {
          'type': '1',
          'name': '订单收入',
          'subName': '胡晓川单人套餐',
          'time': '2021_06_28 13:32:48',
          'money': '99'
        },
        {
          'type': '2',
          'name': '账户提现',
          'subName': '中国工商银行(3053)',
          'time': '2021_06_28 13:32:48',
          'money': '1088'
        },
        {
          'type': '1',
          'name': '订单收入',
          'subName': '胡晓川单人套餐',
          'time': '2021_06_28 13:32:48',
          'money': '99'
        },
        {
          'type': '2',
          'name': '账户提现',
          'subName': '中国工商银行(3053)',
          'time': '2021_06_28 13:32:48',
          'money': '1088'
        },
        {
          'type': '1',
          'name': '订单收入',
          'subName': '胡晓川单人套餐',
          'time': '2021_06_28 13:32:48',
          'money': '99'
        },
        {
          'type': '2',
          'name': '账户提现',
          'subName': '中国工商银行(3053)',
          'time': '2021_06_28 13:32:48',
          'money': '1088'
        },
        {
          'type': '1',
          'name': '订单收入',
          'subName': '胡晓川单人套餐',
          'time': '2021_06_28 13:32:48',
          'money': '99'
        },
        {
          'type': '2',
          'name': '账户提现',
          'subName': '中国工商银行(3053)',
          'time': '2021_06_28 13:32:48',
          'money': '1088'
        },
        {
          'type': '1',
          'name': '订单收入',
          'subName': '胡晓川单人套餐',
          'time': '2021_06_28 13:32:48',
          'money': '99'
        },
        {
          'type': '2',
          'name': '账户提现',
          'subName': '中国工商银行(3053)',
          'time': '2021_06_28 13:32:48',
          'money': '1088'
        }
      ];
      setState(() {
        this._isLoad = false;
        this._commentList.addAll(newsList);
      });
    });
  }

  //下拉刷新
  Future onRefresh() {
    return Future.delayed(Duration(seconds: 1), () {
      print('当前已是最新数据');
    });
  }

  @override
  void dispose() {
    this._scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: this.onRefresh,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: RhColors.colorAppBar,
                  brightness: Brightness.dark,
                  pinned: true,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: RhColors.colorWhite),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  title: Text('账单',
                      style: TextStyle(
                          color: RhColors.colorWhite,
                          fontSize: RhFontSize.fontSize18)),
                  expandedHeight: 56 + ScreenUtil().setHeight(90),
                  flexibleSpace: FlexibleSpaceBar(
                    background: _filterTime(),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((content, index) {
                      if (index < this._commentList.length) {
                        return _billItem(this._commentList[index]);
                      } else {
                        if (this._isLoad) {
                          return LoadingMore();
                        } else {
                          return ListBottom(this._isOver ? '到底了' : '上拉加载更多');
                        }
                      }
                    }, childCount: this._commentList.length + 1),
                  ),
                )
              ],
            )));
  }

  //顶部appbar
  _filterTime() {
    return Column(children: <Widget>[
      SizedBox(height: MediaQuery.of(context).padding.top + 56),
      Container(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
          height: ScreenUtil().setHeight(90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    JhPickerTool.showDatePicker(context,
                        dateType: DateType.YM,
                        minValue: DateTime(2020, 08),
                        maxValue: DateTime(now.year, now.month),
                        clickCallback: (var str, var time) {
                      this.setState(() {
                        _currentMonth = str;
                      });
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _currentMonth,
                        style: TextStyle(
                            color: RhColors.colorWhite,
                            fontSize: RhFontSize.fontSize16,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: RhColors.colorWhite,
                      )
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: '收入',
                        style: TextStyle(
                            fontSize: RhFontSize.fontSize14,
                            color: RhColors.colorWhite),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' +13284.32 ',
                              style: TextStyle(
                                  fontSize: RhFontSize.fontSize18,
                                  fontWeight: FontWeight.bold,
                                  color: RhColors.colorPrimary)),
                          TextSpan(
                              text: '2笔',
                              style: TextStyle(
                                  fontSize: RhFontSize.fontSize14,
                                  color: RhColors.colorWhite))
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: '支出',
                        style: TextStyle(
                            fontSize: RhFontSize.fontSize14,
                            color: RhColors.colorWhite),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' -134.38 ',
                              style: TextStyle(
                                  fontSize: RhFontSize.fontSize18,
                                  fontWeight: FontWeight.bold,
                                  color: RhColors.colorWhite)),
                          TextSpan(
                              text: '1笔',
                              style: TextStyle(
                                  fontSize: RhFontSize.fontSize14,
                                  color: RhColors.colorWhite))
                        ]),
                  )
                ],
              )
            ],
          ))
    ]);
  }

  //账单item
  _billItem(item) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      height: ScreenUtil().setHeight(138),
      decoration: BoxDecoration(
          color: RhColors.colorWhite, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item['name'],
                  style: TextStyle(
                      color: RhColors.colorTitle,
                      fontSize: RhFontSize.fontSize14,
                      fontWeight: FontWeight.bold)),
              Text(item['subName'],
                  style: TextStyle(
                      color: RhColors.colorTitle,
                      fontSize: RhFontSize.fontSize14)),
              Text('操作时间：${item['time']}',
                  style: TextStyle(
                      color: RhColors.colorDesc,
                      fontSize: RhFontSize.fontSize12))
            ],
          ),
          Text('${item['type'] == '1' ? '+' : '-'}${item['money']}',
              style: TextStyle(
                  color: item['type'] == '1'
                      ? RhColors.colorPrimary
                      : RhColors.colorTitle,
                  fontSize: RhFontSize.fontSize16,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
