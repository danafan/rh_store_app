import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../service/config_tool.dart';

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
    _tabController = TabController(vsync: this, initialIndex: 0, length: 4);
  }

  @override
  void dispose() {
    this._tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size(ScreenUtil().setWidth(750), ScreenUtil().setHeight(90)),
            child: AppBar(
              backgroundColor: RhColors.colorAppBar,
              brightness: Brightness.dark,
              title: TabBar(
                  controller: this._tabController,
                  labelColor: RhColors.colorTitle,
                  unselectedLabelColor: RhColors.colorTitle,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(
                      color: RhColors.colorWhite,
                      fontSize: RhFontSize.fontSize16),
                  indicatorColor: RhColors.colorPrimary,
                  indicatorWeight: 4.0,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(
                        child: Text('全部',
                            style: TextStyle(
                                color: RhColors.colorWhite,
                                fontSize: RhFontSize.fontSize16))),
                    Tab(
                        child: Text('待核销',
                            style: TextStyle(
                                color: RhColors.colorWhite,
                                fontSize: RhFontSize.fontSize16))),
                    Tab(
                        child: Text('已完成',
                            style: TextStyle(
                                color: RhColors.colorWhite,
                                fontSize: RhFontSize.fontSize16))),
                    Tab(
                        child: Text('已退款',
                            style: TextStyle(
                                color: RhColors.colorWhite,
                                fontSize: RhFontSize.fontSize16))),
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
