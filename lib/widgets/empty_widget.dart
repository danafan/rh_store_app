import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/config_tool.dart';

class EmptyWidget extends StatelessWidget {

  final String cateId;
  EmptyWidget({this.cateId});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有任何菜品哦，快去添加吧~',
                style: TextStyle(
                    color: RhColors.colorTitle,
                    fontSize: RhFontSize.fontSize14)),
            SizedBox(height: ScreenUtil().setHeight(10)),
            InkWell(
              onTap: () {
                Map arg = {
                  'pageType': '1',
                  'id': cateId
                };
                Navigator.pushNamed(context, '/add_menu', arguments: arg);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: RhColors.colorPrimary,
                    borderRadius: BorderRadius.circular(3)),
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(150),
                height: ScreenUtil().setHeight(60),
                child: Text('去添加',
                    style: TextStyle(
                        color: RhColors.colorWhite,
                        fontSize: RhFontSize.fontSize12)),
              ),
            )
          ],
        ));
  }
}