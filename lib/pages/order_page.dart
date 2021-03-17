import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../widgets/order_list.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  //TabBar控制器
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size(ScreenUtil().setWidth(750), ScreenUtil().setHeight(90)),
            child: AppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              title: TabBar(
                  controller: this._tabController,
                  labelColor: Color(0xff333333),
                  unselectedLabelColor: Color(0xff333333),
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  unselectedLabelStyle: TextStyle(fontSize: 15),
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 4.0,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(text: '全部'),
                    Tab(text: '待核销'),
                    Tab(text: '已完成'),
                    Tab(text: '已退款')
                  ]),
            )),
        body: TabBarView(
          controller: this._tabController,
          children: <Widget>[
            //全部
            OrderList('1'),
            //待核销
            OrderList('2'),
            //已完成
            OrderList('3'),
            //已退款
            OrderList('4')
          ],
        ));
  }
}
