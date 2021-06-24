import 'dart:async';

import 'package:flutter/material.dart';

import './message_item.dart';
import './loading_more.dart';
import './list_bottom.dart';

class MessageList extends StatefulWidget {
  String _listType = '1'; //套餐列表筛选条件（1:系统消息；2:平台公告）
  MessageList(this._listType);
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  //消息列表
  List<Map> _messageList = [];
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
    List<Map> newsList = [
      {'id': '1', 'type': '1', 'isRead': '0'},
      {'id': '2', 'type': '2', 'isRead': '0'},
      {'id': '3', 'type': '3', 'isRead': '1'}
    ];
    //初始化列表数据
    this._messageList.addAll(newsList);
    //监听列表滚动
    this._scrollController.addListener(() {
      // 滑动到底部的关键判断
      if (!this._isLoad &&
          this._scrollController.position.pixels >=
              this._scrollController.position.maxScrollExtent) {
        if (this._messageList.length == 5) {
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
      List<Map> newsList = [
        {'id': '1', 'type': '1', 'isRead': '0'},
        {'id': '2', 'type': '2', 'isRead': '0'},
        {'id': '3', 'type': '3', 'isRead': '1'}
      ];
      setState(() {
        this._isLoad = false;
        this._messageList.addAll(newsList);
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
          controller: this._scrollController,
          itemCount: this._messageList.length + 1,
          itemBuilder: (context, index) {
            if (index < this._messageList.length) {
              return MessageItem(this._listType,this._messageList[index]);
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
