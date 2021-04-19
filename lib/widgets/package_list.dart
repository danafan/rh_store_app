import 'dart:async';

import 'package:flutter/material.dart';

import './package_item.dart';
import './loading_more.dart';
import './list_bottom.dart';

class PackageList extends StatefulWidget {
  String _listType = '1'; //套餐列表筛选条件（1:已上架；2:待上架；3:待审核；4:已拒绝）
  PackageList(this._listType);
  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  //套餐列表
  List<String> packageList = [];
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
    List<String> newsList = ['1','2','3','4','5'];
    //初始化列表数据
    this.packageList.addAll(newsList);
    //监听列表滚动
    this._scrollController.addListener(() {
      // 滑动到底部的关键判断
      if (!this._isLoad &&
          this._scrollController.position.pixels >=
              this._scrollController.position.maxScrollExtent) {
        if (this.packageList.length == 5) {
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
      List<String> newsList = ['1','2','3','4','5'];
      setState(() {
        this._isLoad = false;
        this.packageList.addAll(newsList);
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
    return RefreshIndicator(
      onRefresh: this.onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.all(8),
          controller: this._scrollController,
          itemCount: this.packageList.length + 1,
          itemBuilder: (context, index) {
            if (index < this.packageList.length) {
              return PackageItem(this.packageList[index],index);
            } else {
              if (this._isLoad) {
                return LoadingMore();
              } else {
                return ListBottom(this._isOver ? '到底了' : '上拉加载更多');
              }
            }
          }),
    );
  }
}
