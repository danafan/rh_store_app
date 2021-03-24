import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/order_page.dart';
import '../pages/comment_page.dart';
import '../pages/my_page.dart';

class NavigatorBar extends StatefulWidget {
  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _currentPageIndex = 0; //当前选中的导航下标

  List<Widget> _pageList = [
    HomePage(),
    OrderPage(),
    CommentPage(),
    MyPage()
  ]; //所有页面列表

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: this._currentPageIndex,
        children: this._pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentPageIndex,
          onTap: (index) {
            this.setState(() {
              _currentPageIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor:Colors.white,
          fixedColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.architecture_sharp), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: '订单'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cake_rounded), label: '评价'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: '我的')
          ]),
    );
  }
}
