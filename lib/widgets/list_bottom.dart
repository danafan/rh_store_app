import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../service/config_tool.dart';

class ListBottom extends StatelessWidget {
  final String toastContent;
  ListBottom({this.toastContent});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
      alignment: Alignment.center,
      child: Text(
        '${this.toastContent}',
        style: TextStyle(
          fontSize: RhFontSize.fontSize14,
          color: RhColors.colorDesc,
        ),
      ),
    );
  }
}
