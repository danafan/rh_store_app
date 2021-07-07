import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/config_tool.dart';

class SearchWidget extends StatefulWidget {
  final callBack;
  SearchWidget({this.callBack});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  //搜索内容
  final _searchController = new TextEditingController();

  @override
  void dispose() {
    this._searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.search, color: RhColors.colorPrimary),
        Expanded(
            child: TextField(
          controller: this._searchController,
          style: TextStyle(color: RhColors.colorTitle, fontSize: RhFontSize.fontSize16),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '输入菜品名称',
            hintStyle: TextStyle(fontSize: RhFontSize.fontSize16),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
          ),
        )),
        InkWell(
            onTap: () {
              widget.callBack(this._searchController.text);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: RhColors.colorPrimary,
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setHeight(25)))),
                width: ScreenUtil().setWidth(120),
                height: ScreenUtil().setHeight(50),
                alignment: Alignment.center,
                child: Text(
                  '搜索',
                  style: TextStyle(color: RhColors.colorWhite, fontSize: RhFontSize.fontSize14),
                )))
      ],
    );
  }
}
