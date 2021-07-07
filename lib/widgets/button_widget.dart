import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final buttonBack;
  ButtonWidget({this.text, this.buttonBack});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          this.buttonBack();
        },
        child: Container(
              width: ScreenUtil().setWidth(680),
              height: ScreenUtil().setHeight(80),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(40)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffe84d2a),
                    Color(0xffec722e),
                  ],
                ),
              ),
              child: Text(
                '${this.text}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )));
  }
}
