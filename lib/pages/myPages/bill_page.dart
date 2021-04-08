import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:rh_store_app/widgets/list_bottom.dart';
import 'package:rh_store_app/widgets/loading_more.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  //当前时间
  var now = new DateTime.now();
  //评论列表
  List<String> _commentList = [];
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
        if (this._commentList.length >= 100) {
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
  }

  //加载更多数据
  Future _loadMoreData() {
    return Future.delayed(Duration(seconds: 1), () {
      List<String> newsList = ['1', '2', '3', '1', '2', '3'];
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
        appBar: PreferredSize(
            preferredSize: Size(
                ScreenUtil().setWidth(750),
                ScreenUtil().setHeight(260) -
                    MediaQuery.of(context).padding.top),
            child: AppBar(
                backgroundColor: Color(0xffffffff),
                brightness: Brightness.light,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Color(0xff333333)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                title: Text('账单', style: TextStyle(color: Color(0xff333333))),
                flexibleSpace: _filterTime())),
        body: RefreshIndicator(
            onRefresh: this.onRefresh,
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                controller: this._scrollController,
                itemCount: this._commentList.length + 1,
                itemBuilder: (context, index) {
                  if (index < this._commentList.length) {
                    return _billItem('1', '100');
                  } else {
                    if (this._isLoad) {
                      return LoadingMore();
                    } else {
                      return ListBottom(this._isOver ? '到底了' : '上拉加载更多');
                    }
                  }
                })));
  }

  //时间筛选
  _filterTime() {
    return Column(children: <Widget>[
      SizedBox(height: ScreenUtil().setHeight(160)),
      Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: ScreenUtil().setHeight(90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(this.now.year, 1),
                        maxTime: DateTime(
                            this.now.year, this.now.month),
                        onConfirm: (date) {
                          print(date);
                      // _judgeTime('1', date);
                    }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '2020-04',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_right)
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: '收入',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff8a8a8a)),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' +13284.32 ',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffe25d2b))),
                          TextSpan(
                              text: '2笔',
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xff8a8a8a)))
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: '支出',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff8a8a8a)),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' -134.38 ',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff333333))),
                          TextSpan(
                              text: '1笔',
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xff8a8a8a)))
                        ]),
                  )
                ],
              )
            ],
          ))
    ]);
  }

  //账单item
  _billItem(type, number) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      height: ScreenUtil().setHeight(138),
      decoration: BoxDecoration(
          color: Color(0xffffffff), borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              type == '1'
                  ? Text('订单收入',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.bold))
                  : Text('提现',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
              type == '1'
                  ? Text('胡晓川单人套餐',
                      style: TextStyle(color: Color(0xff8a8a8a), fontSize: 14))
                  : Text('中国银行（3053）',
                      style: TextStyle(color: Color(0xff8a8a8a), fontSize: 14)),
              Text('操作时间：2020-08-20 13:42:34',
                  style: TextStyle(color: Color(0xff8a8a8a), fontSize: 14))
            ],
          ),
          Text('${type == '1' ? '+' : '-'}100',
              style: TextStyle(
                  color: type == '1' ? Color(0xffe25d2b) : Color(0xff333333),
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
