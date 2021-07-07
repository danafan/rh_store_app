import 'dart:async';
import 'package:flutter/material.dart';

import './order_item.dart';
import '../../widgets/loading_more.dart';
import '../../widgets/list_bottom.dart';

class OrderList extends StatefulWidget {
  final String listType; //订单列表筛选条件（1:全部；2:待核销；3:已完成；4:已退款）
  OrderList({this.listType});
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  //订单列表
  List<Map> orderList = [];
  //是否加载
  bool _isLoad = false;
  //所有数据加载完毕
  bool _isOver = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    List<Map> newsList = [{'orderStatus':'1'},{'orderStatus':'2'},{'orderStatus':'3'}];
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
      List<Map> newsList = [{'orderStatus':'1'},{'orderStatus':'2'},{'orderStatus':'3'}];
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: this.onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.all(8),
          controller: this._scrollController,
          itemCount: this.orderList.length + 1,
          itemBuilder: (context, index) {
            if (index < this.orderList.length) {
              return OrderItem(orderInfo:this.orderList[index]);
            } else {
              if (this._isLoad) {
                return LoadingMore();
              } else {
                return ListBottom(toastContent:this._isOver ? '到底了' : '上拉加载更多');
              }
            }
          }),
    );
  }
}
