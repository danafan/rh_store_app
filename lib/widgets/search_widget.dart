import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  final callBack;
  SearchWidget({this.callBack});
  //搜索内容
  final _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.search, color: Color(0xffe25d2b)),
        Expanded(
            child: TextField(
          controller: this._searchController,
          style: TextStyle(color: Color(0xff333333), fontSize: 16),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '输入菜品名称',
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
          ),
        )),
        InkWell(
            onTap: () {
              this.callBack(this._searchController.text);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffe25d2b),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setHeight(25)))),
                width: ScreenUtil().setWidth(120),
                height: ScreenUtil().setHeight(50),
                alignment: Alignment.center,
                child: Text(
                  '搜索',
                  style: TextStyle(color: Color(0xffffffff), fontSize: 13),
                )))
      ],
    );
  }
}
