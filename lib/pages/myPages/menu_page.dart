import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../widgets/search_widget.dart';
import '../../widgets/list_bottom.dart';
import '../../widgets/loading_more.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/dialog_widget.dart';

import '../../service/config_tool.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  //所有菜品列表
  List _menuList = [];
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
  }

  @override
  void dispose() {
    this._scrollController.dispose();
    super.dispose();
  }

  //加载更多数据
  Future _loadMoreData() {
    return Future.delayed(Duration(seconds: 2), () {
      List newsList = [
        {'id': '1', 'name': '老坛酸菜鱼', 'price': 48, 'num': 1, 'unit': '份'},
        {'id': '2', 'name': '青椒肉丝', 'price': 22, 'num': 1, 'unit': '碗'},
        {'id': '3', 'name': '小炒肉', 'price': 18, 'num': 1, 'unit': '盆'},
        {'id': '1', 'name': '老坛酸菜鱼', 'price': 48, 'num': 1, 'unit': '份'},
        {'id': '2', 'name': '青椒肉丝', 'price': 22, 'num': 1, 'unit': '碗'},
        {'id': '3', 'name': '小炒肉', 'price': 18, 'num': 1, 'unit': '盆'},
        {'id': '1', 'name': '老坛酸菜鱼', 'price': 48, 'num': 1, 'unit': '份'},
        {'id': '2', 'name': '青椒肉丝', 'price': 22, 'num': 1, 'unit': '碗'},
        {'id': '3', 'name': '小炒肉', 'price': 18, 'num': 1, 'unit': '盆'},
        {'id': '1', 'name': '老坛酸菜鱼', 'price': 48, 'num': 1, 'unit': '份'},
        {'id': '2', 'name': '青椒肉丝', 'price': 22, 'num': 1, 'unit': '碗'},
        {'id': '3', 'name': '小炒肉', 'price': 18, 'num': 1, 'unit': '盆'},
        {'id': '1', 'name': '老坛酸菜鱼', 'price': 48, 'num': 1, 'unit': '份'},
        {'id': '2', 'name': '青椒肉丝', 'price': 22, 'num': 1, 'unit': '碗'},
        {'id': '3', 'name': '小炒肉', 'price': 18, 'num': 1, 'unit': '盆'},
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: RhColors.colorAppBar,
            brightness: Brightness.dark,
            title:
                Text('菜单管理', style: TextStyle(fontSize: RhFontSize.fontSize18)),
            actions: <Widget>[
              InkWell(
                  onTap: () {
                    Map arg = {'pageType': '1'};
                    Navigator.pushNamed(context, '/add_menu', arguments: arg);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: RhColors.colorPrimary,
                        size: 16,
                      ),
                      Text(
                        '添加菜品',
                        style: TextStyle(
                            color: RhColors.colorPrimary,
                            fontSize: RhFontSize.fontSize14),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(30))
                    ],
                  ))
            ],
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
                    // 触摸收起键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                    print(e);
                  },
                ),
              ),
              preferredSize: Size(double.infinity, ScreenUtil().setHeight(60)),
            )),
        body: this._menuList.length == 0
            ? EmptyWidget(cateId: '')
            : RefreshIndicator(
                onRefresh: this.onRefresh,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(8)),
                    controller: this._scrollController,
                    itemCount: this._menuList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < this._menuList.length) {
                        return Slidable(
                            key: ValueKey("$index"),
                            //右侧滑动部分
                            secondaryActions: rightActionsArray(index, context),
                            //滑动的交互效果
                            actionPane: SlidableDrawerActionPane(),
                            //item内容
                            child: InkWell(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Map arg = {'pageType': '2'};
                                  Navigator.pushNamed(context, '/add_menu',
                                      arguments: arg);
                                },
                                child: _menuItemWidget(index)));
                      } else {
                        if (this._isLoad) {
                          return LoadingMore();
                        } else {
                          return ListBottom(toastContent:this._isOver ? '到底了' : '上拉加载更多');
                        }
                      }
                    })));
  }

  //右侧可滑动的部分
  List<Widget> rightActionsArray(index, context) {
    List<Widget> _settingButton = [];
    _settingButton
        .add(_iconSlideAction(Icons.delete, '删除', RhColors.colorDesc, () {
      showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: DialogWidget(
                title: '提示',
                contentWidget: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(30)),
                  child: Text('确认删除?'),
                ),
                cancelFun: () {},
                confirmFun: () {
                  Navigator.pop(context);
                  print('已删除');
                }),
          );
        },
      ).then((val) {});
    }));
    return _settingButton;
  }

  //滑动的按钮组件
  _iconSlideAction(icon, text, color, callback) {
    return IconSlideAction(
      //图标
      icon: icon,
      //文字
      caption: text,
      //背景色
      color: color,
      //点击事件回调
      onTap: callback,
      //点击 false 不关闭 ，true关闭
      closeOnTap: false,
    );
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
            Icon(Icons.arrow_forward_ios, size: 16, color: RhColors.colorDesc)
          ],
        ));
  }
}
