import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/search_widget.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0a0b17),
          brightness: Brightness.light,
          title: Text('菜单管理', style: TextStyle(fontSize: 18)),
          bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(left:ScreenUtil().setWidth(15),right:ScreenUtil().setWidth(15)),
              color: Color(0xffffffff),
              height: ScreenUtil().setHeight(70),
              width: double.infinity,
              child: SearchWidget(callBack: (e){
                print(e);
              },),
            ),
            preferredSize: Size(double.infinity, ScreenUtil().setHeight(60)),
          )),
    );
  }
}
