import 'dart:async';

import 'package:flutter/material.dart';

import './order_item.dart';

class OrderList extends StatefulWidget {
  String _listType = '1'; //订单列表筛选条件（1:全部；2:待核销；3:已完成；4:已退款）
  OrderList(this._listType);
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  //订单列表
  List<String> orderList = [];
  //是否加载
  bool _isLoad = false;
  //所有数据加载完毕
  bool _isOver = false;
  ScrollController _scrollController = new ScrollController();
  //筛选条件
  String _listType;

  @override
  void initState() {
    super.initState();
    _listType = widget._listType;
    List<String> newsList = [widget._listType, widget._listType];
    //初始化列表数据
    orderList.addAll(newsList);
    //监听列表滚动
    this._scrollController.addListener(() {
      // 滑动到底部的关键判断
      if (!this._isLoad &&
          this._scrollController.position.pixels >=
              this._scrollController.position.maxScrollExtent) {
        if (this.orderList.length == 5) {
          //如果所有数据加载完毕
          setState(() {
            this._isOver = true;
          });
        } else {
          // 开始加载数据
          setState(() {
            this._isLoad = true;
            //加载更多数据
            this.loadMoreData();
          });
        }
      }
    });
  }

  //加载更多数据
  Future loadMoreData() {
    return Future.delayed(Duration(seconds: 3), () {
      List<String> newsList = [this._listType];
      setState(() {
        this._isLoad = false;
        this.orderList.addAll(newsList);
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
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: RefreshIndicator(
        onRefresh: this.onRefresh,
        child: ListView.builder(
            controller: this._scrollController,
            itemCount: this.orderList.length + 1,
            itemBuilder: (context, index) {
              if (index < this.orderList.length) {
                return OrderItem(this.orderList[index]);
              } else {
                return this.renderBottom();
              }
            }),
      ),
    );
  }

  //列表底部加载中提示
  Widget renderBottom() {
    if (this._isLoad) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '努力加载中...',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          this._isOver?'到底了':'上拉加载更多',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF333333),
          ),
        ),
      );
    }
  }
}
