import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/package_list.dart';

import '../../service/config_tool.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: RhColors.colorAppBar,
          brightness: Brightness.dark,
          title: Text('套餐管理',
              style: TextStyle(
                  color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  Map arg = {'pageType': '1'}; //1:新建套餐；2:编辑套餐
                  Navigator.pushNamed(context, '/created_package',
                      arguments: arg);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: RhColors.colorPrimary,
                      size: RhFontSize.fontSize16,
                    ),
                    Text(
                      '新建',
                      style: TextStyle(
                          color: RhColors.colorPrimary,
                          fontSize: RhFontSize.fontSize14),
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
                color: RhColors.colorWhite,
                child: TabBar(
                    controller: this._tabController,
                    labelColor: RhColors.colorTitle,
                    unselectedLabelColor: RhColors.colorTitle,
                    labelStyle: TextStyle(
                        fontSize: RhFontSize.fontSize14,
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                        TextStyle(fontSize: RhFontSize.fontSize14),
                    indicatorColor: RhColors.colorPrimary,
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
          PackageList(listType:'1'),
          //待上架
          PackageList(listType:'2'),
          //待审核
          PackageList(listType:'3'),
          //已拒绝
          PackageList(listType:'4')
        ],
      ),
    );
  }
}
