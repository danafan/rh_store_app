import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './message_list.dart';

import '../../service/config_tool.dart';

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
          backgroundColor: RhColors.colorAppBar,
          brightness: Brightness.dark,
          title: Text('消息中心',
              style: TextStyle(
                  color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
          bottom: PreferredSize(
              preferredSize:
                  Size(ScreenUtil().setWidth(750), ScreenUtil().setHeight(80)),
              child: Container(
                height: ScreenUtil().setHeight(80),
                color: RhColors.colorWhite,
                child: TabBar(
                    controller: this._tabController,
                    labelColor: RhColors.colorTitle,
                    unselectedLabelColor: RhColors.colorTitle,
                    labelStyle: TextStyle(
                        fontSize: RhFontSize.fontSize16,
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                        TextStyle(fontSize: RhFontSize.fontSize16),
                    indicatorColor: RhColors.colorPrimary,
                    indicatorWeight: 4.0,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[Tab(text: '系统消息'), Tab(text: '平台公告')]),
              ))),
      body: TabBarView(
        controller: this._tabController,
        children: <Widget>[MessageList(listType:'1'), MessageList(listType:'2')],
      ),
    );
  }
}
