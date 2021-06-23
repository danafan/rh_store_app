import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../widgets/list_bottom.dart';
import '../widgets/loading_more.dart';
import '../widgets/comment_item.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
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
        if (this._commentList.length >= 5) {
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
      List<String> newsList = ['1', '2', '3'];
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
            preferredSize:
                Size(ScreenUtil().setWidth(750), ScreenUtil().setHeight(90)),
            child: AppBar(
              backgroundColor: Color(0xff0a0b17),
              brightness: Brightness.dark,
              title: _topLabel(),
            )),
        body: RefreshIndicator(
            onRefresh: this.onRefresh,
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                controller: this._scrollController,
                itemCount: this._commentList.length + 1,
                itemBuilder: (context, index) {
                  if (index < this._commentList.length) {
                    return CommentItem();
                  } else {
                    if (this._isLoad) {
                      return LoadingMore();
                    } else {
                      return ListBottom(this._isOver ? '到底了' : '上拉加载更多');
                    }
                  }
                })));
  }

  //顶部模块
  _topLabel() {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('综合评分',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('4.8',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18)),
                    Text('(分)',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))
                  ],
                )
              ]),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('评价总数',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('762',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18)),
                    Text('(条)',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))
                  ],
                )
              ]),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('好评率',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('89',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18)),
                    Text('(%)',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))
                  ],
                )
              ])
        ]));
  }
}
