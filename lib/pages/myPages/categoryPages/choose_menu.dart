import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/search_widget.dart';
import '../../../widgets/list_bottom.dart';
import '../../../widgets/loading_more.dart';
import '../../../widgets/empty_widget.dart';

import '../../../service/toast_tool.dart';
import '../../../service/config_tool.dart';

class ChooseMenu extends StatefulWidget {
  final Map arguments;
  ChooseMenu({this.arguments});
  @override
  _ChooseMenuState createState() => _ChooseMenuState();
}

class _ChooseMenuState extends State<ChooseMenu> {
  //传递过来的分类ID
  String _categoryId = "";
  //所有菜品列表
  List _menuList = [];
  //选中的菜品ID列表
  List _activeIdList = [];
  //是否加载中
  bool _isLoad = false;
  //是否加载了全部
  bool _isOver = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    //获取列表
    _loadMoreData();
    //监听列表滚动
    this._scrollController.addListener(() {
      // 滑动到底部的关键判断
      if (!this._isLoad &&
          this._scrollController.position.pixels >=
              this._scrollController.position.maxScrollExtent) {
        if (this._menuList.length >= 40) {
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
    this.setState(() {
      _categoryId = widget.arguments['id'];
    });
  }

  //加载更多数据
  Future _loadMoreData() {
    return Future.delayed(Duration(seconds: 2), () {
      List newsList = [
        {
          'id': '1',
          'name': '老坛酸菜鱼',
          'price': 48,
          'is_select': false,
          'unit': '份'
        },
        {
          'id': '2',
          'name': '青椒肉丝',
          'price': 22,
          'is_select': false,
          'unit': '碗'
        },
        {
          'id': '3',
          'name': '小炒肉',
          'price': 18,
          'is_select': false,
          'unit': '盆'
        },
        {
          'id': '1',
          'name': '老坛酸菜鱼',
          'price': 48,
          'is_select': false,
          'unit': '份'
        },
        {
          'id': '2',
          'name': '青椒肉丝',
          'price': 22,
          'is_select': false,
          'unit': '碗'
        },
        {
          'id': '3',
          'name': '小炒肉',
          'price': 18,
          'is_select': false,
          'unit': '盆'
        },
        {
          'id': '1',
          'name': '老坛酸菜鱼',
          'price': 48,
          'is_select': false,
          'unit': '份'
        },
        {
          'id': '2',
          'name': '青椒肉丝',
          'price': 22,
          'is_select': false,
          'unit': '碗'
        },
        {
          'id': '3',
          'name': '小炒肉',
          'price': 18,
          'is_select': false,
          'unit': '盆'
        },
        {
          'id': '1',
          'name': '老坛酸菜鱼',
          'price': 48,
          'is_select': false,
          'unit': '份'
        },
        {
          'id': '2',
          'name': '青椒肉丝',
          'price': 22,
          'is_select': false,
          'unit': '碗'
        },
        {
          'id': '3',
          'name': '小炒肉',
          'price': 18,
          'is_select': false,
          'unit': '盆'
        },
        {
          'id': '1',
          'name': '老坛酸菜鱼',
          'price': 48,
          'is_select': false,
          'unit': '份'
        },
        {
          'id': '2',
          'name': '青椒肉丝',
          'price': 22,
          'is_select': false,
          'unit': '碗'
        },
        {
          'id': '3',
          'name': '小炒肉',
          'price': 18,
          'is_select': false,
          'unit': '盆'
        },
      ];
      setState(() {
        this._isLoad = false;
        this._menuList.addAll(newsList);
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
        appBar: AppBar(
            backgroundColor: RhColors.colorAppBar,
            brightness: Brightness.dark,
            title: Text('选择菜品',
                style: TextStyle(
                    color: RhColors.colorWhite,
                    fontSize: RhFontSize.fontSize18)),
            bottom: PreferredSize(
              child: Container(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(15),
                    right: ScreenUtil().setWidth(15)),
                color: RhColors.colorWhite,
                height: ScreenUtil().setHeight(70),
                width: double.infinity,
                child: SearchWidget(
                  callBack: (e) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    print(e);
                  },
                ),
              ),
              preferredSize: Size(double.infinity, ScreenUtil().setHeight(60)),
            )),
        body: Column(
          children: <Widget>[
            Expanded(
                child: this._menuList.length == 0
                    ? EmptyWidget(cateId: this._categoryId)
                    : RefreshIndicator(
                        onRefresh: this.onRefresh,
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(8)),
                            controller: this._scrollController,
                            itemCount: this._menuList.length + 1,
                            itemBuilder: (context, index) {
                              if (index < this._menuList.length) {
                                return InkWell(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      this.setState(() {
                                        this._menuList[index]['is_select'] =
                                            !this._menuList[index]['is_select'];
                                        _activeIdList = [];
                                      });
                                      for (var i = 0;
                                          i < this._menuList.length;
                                          i++) {
                                        if (this._menuList[i]['is_select'] ==
                                            true) {
                                          this.setState(() {
                                            _activeIdList
                                                .add(this._menuList[i]['id']);
                                          });
                                        }
                                      }
                                    },
                                    child: _menuItemWidget(index));
                              } else {
                                if (this._isLoad) {
                                  return LoadingMore();
                                } else {
                                  return ListBottom(
                                      toastContent:this._isOver ? '到底了' : '上拉加载更多');
                                }
                              }
                            }))),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: RhColors.colorWhite,
                  border: Border(
                      top: BorderSide(width: 2, color: Color(0xffF1F6F9)))),
              height: ScreenUtil().setHeight(90),
              child: Row(
                children: <Widget>[
                  Container(
                      width: ScreenUtil().setWidth(220),
                      alignment: Alignment.center,
                      color: Color(0xff0C0D0D),
                      child: Text(
                        '已选（${_activeIdList.length}）',
                        style: TextStyle(
                            color: RhColors.colorWhite,
                            fontSize: RhFontSize.fontSize14),
                      )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      if (_activeIdList.length == 0) {
                        ToastTool.toastWidget(context, msg: '还没有选择的菜品哦～');
                      } else {
                        ToastTool.toastWidget(context, msg: '菜品添加成功~');
                        print(this._activeIdList);
                        print(this._categoryId);
                        Navigator.pushNamed(context, '/category_page');
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        color: _activeIdList.length > 0
                            ? RhColors.colorPrimary
                            : RhColors.colorDesc,
                        child: Text(_activeIdList.length > 0 ? '选好了' : '请选择',
                            style: TextStyle(
                                color: RhColors.colorWhite,
                                fontSize: RhFontSize.fontSize14))),
                  ))
                ],
              ),
            )
          ],
        ));
  }

  //某一个菜品
  _menuItemWidget(index) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: RhColors.colorLine))),
        height: ScreenUtil().setHeight(130),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //菜品图片
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                  'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                  height: ScreenUtil().setHeight(110),
                  width: ScreenUtil().setHeight(110),
                  fit: BoxFit.cover),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            //名称和价格
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text(this._menuList[index]['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: RhColors.colorTitle,
                          fontSize: RhFontSize.fontSize14,
                          fontWeight: FontWeight.bold)),
                  Text(
                      '¥${this._menuList[index]['price']}/${this._menuList[index]['unit']}',
                      style: TextStyle(
                          color: RhColors.colorPrimary,
                          fontSize: RhFontSize.fontSize14))
                ])),
            this._menuList[index]['is_select'] == true
                ? Icon(Icons.check_circle,
                    size: 20, color: RhColors.colorPrimary)
                : Icon(Icons.check_circle_outline,
                    size: 20, color: RhColors.colorDesc)
          ],
        ));
  }
}
