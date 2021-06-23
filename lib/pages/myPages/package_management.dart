import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/package_list.dart';

class PackageManagement extends StatefulWidget {
  @override
  _PackageManagementState createState() => _PackageManagementState();
}

class _PackageManagementState extends State<PackageManagement>
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
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0a0b17),
          brightness: Brightness.dark,
          title: Text('套餐管理',
              style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  Map arg = {'pageType': '1'};    //1:新建套餐；2:编辑套餐
                  Navigator.pushNamed(context, '/created_package',
                      arguments: arg);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Color(0xffe25d2b),
                      size: 16,
                    ),
                    Text(
                      '新建',
                      style: TextStyle(color: Color(0xffe25d2b), fontSize: 14),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(30))
                  ],
                ))
          ],
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
                    tabs: <Widget>[
                      Tab(text: '已上架'),
                      Tab(text: '待上架'),
                      Tab(text: '待审核'),
                      Tab(text: '已拒绝')
                    ]),
              ))),
      body: TabBarView(
        controller: this._tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          //已上架
          PackageList('1'),
          //待上架
          PackageList('2'),
          //待审核
          PackageList('3'),
          //已拒绝
          PackageList('4')
        ],
      ),
    );
  }
}
