import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/message_list.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  //TabBar控制器
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  void dispose() {
    this._tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0a0b17),
          brightness: Brightness.dark,
          title: Text('消息中心',
              style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
          bottom: PreferredSize(
              preferredSize:
                  Size(ScreenUtil().setWidth(750), ScreenUtil().setHeight(80)),
              child: Container(
                height: ScreenUtil().setHeight(80),
                color: Color(0xffffffff),
                child: TabBar(
                    controller: this._tabController,
                    labelColor: Color(0xff333333),
                    unselectedLabelColor: Color(0xff333333),
                    labelStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: TextStyle(fontSize: 15),
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 4.0,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[Tab(text: '系统消息'), Tab(text: '平台公告')]),
              ))),
      body: TabBarView(
        controller: this._tabController,
        children: <Widget>[MessageList('1'), MessageList('2')],
      ),
    );
  }
}
