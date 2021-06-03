import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  //所有分类列表
  List _cateList = [
    {'id': '1', 'name': '主食'},
    {'id': '2', 'name': '凉菜'},
    {'id': '3', 'name': '热菜'},
    {'id': '4', 'name': '蒸菜'}
  ];
  //选中的分类下标
  int _activeCateIndex = 0;
  //所有菜品列表
  List _menuList = [
    {'id': '1', 'name': '老坛酸菜鱼', 'price': 48, 'num': 1, 'unit': '份'},
    {'id': '2', 'name': '青椒肉丝', 'price': 22, 'num': 1, 'unit': '碗'},
    {'id': '3', 'name': '小炒肉', 'price': 18, 'num': 1, 'unit': '盆'}
  ];
  //选中的菜品下标
  int _activeMenuIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0a0b17),
          title: Text('分类管理', style: TextStyle(fontSize: 18))),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(
                  children: <Widget>[_categoryWidget(), _menulistWidget()])),
          Container(
              height: ScreenUtil().setHeight(90), child: _bottomRowWidget())
        ],
      ),
    );
  }

  //上面左侧所有分类列表
  _categoryWidget() {
    return Container(
        color: Color(0xfff0f5f8),
        width: ScreenUtil().setWidth(220),
        child: ListView.builder(
            itemCount: this._cateList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    this.setState(() {
                      _activeCateIndex = index;
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      color: this._activeCateIndex == index
                          ? Color(0xffffffff)
                          : Color(0xfff6fbfe),
                      height: ScreenUtil().setHeight(90),
                      alignment: Alignment.center,
                      child: Text(
                        this._cateList[index]['name'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: this._activeCateIndex == index
                                ? Color(0xffe25d2b)
                                : Color(0xff333333),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )));
            }));
  }

  //底部弹框显示分类下菜品列表
  _menulistWidget() {
    return Expanded(
        child: ListView.builder(
            padding: EdgeInsets.only(left: 8),
            itemCount: this._menuList.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey("$index"),
                //右侧滑动部分
                secondaryActions: rightActionsArray(index, context),
                //滑动的交互效果
                actionPane: SlidableDrawerActionPane(),
                //item内容
                child: _menuItemWidget(index),
              );
            }));
  }

  //右侧可滑动的部分
  List<Widget> rightActionsArray(index, context) {
    List<Widget> _settingButton = [];
    _settingButton
        .add(_iconSlideAction(Icons.delete, '删除', Color(0xff8a8a8a), () {
      print('删除');
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
            border: Border(bottom: BorderSide(color: Color(0xffF1F6F9)))),
        height: ScreenUtil().setHeight(130),
        padding: EdgeInsets.only(right: 8),
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
                          color: Color(0xff333333),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text(
                      '¥${this._menuList[index]['price']}/${this._menuList[index]['unit']}',
                      style: TextStyle(color: Color(0xffe25d2b), fontSize: 14))
                ])),
          ],
        ));
  }

  //下面的操作按钮行
  _bottomRowWidget() {
    return Row(children: <Widget>[
      InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/category_management');
          },
          child: Container(
              color: Color(0xfff9f9f9),
              width: ScreenUtil().setWidth(220),
              alignment: Alignment.center,
              child: Text('分类管理',
                  style: TextStyle(color: Color(0xff333333), fontSize: 14)))),
      Expanded(
          child: Container(
              height: ScreenUtil().setHeight(90),
              color: Color(0xffe25d2b),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add_circle_outline,
                        size: 18, color: Color(0xffffffff)),
                    Text('添加菜品',
                        style:
                            TextStyle(color: Color(0xffffffff), fontSize: 14)),
                  ])))
    ]);
  }
}
