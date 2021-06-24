import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../service/config_tool.dart';

class MessageItem extends StatefulWidget {
  String _listType;
  Map _messageItem;
  MessageItem(this._listType,this._messageItem);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget._messageItem['isRead'] == '0'?RhColors.colorPrimary:Color(0xffffffff),
          border: Border(bottom: BorderSide(color: Color(0xffEDF0F7)))),
      height: ScreenUtil().setHeight(120),
      child: Row(
        children: <Widget>[
          Container(
            color: widget._messageItem['isRead'] == '0'?Color(0xffe25d2b):Color(0xffffffff),
            width: ScreenUtil().setWidth(6),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Container(
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setWidth(90),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(50)),
                  child: Container(
                    alignment: Alignment.center,
                    color: Color(0xffe25d2b),
                    width: ScreenUtil().setWidth(90),
                    height: ScreenUtil().setWidth(90),
                    child: Icon(widget._listType == '1'?Icons.notifications:Icons.volume_up,color: Color(0xffffffff),),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('接单通知',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text('2021-03-23 13:45:32',
                              style: TextStyle(
                                  color: Color(0xff8a8a8a), fontSize: 14))
                        ],
                      ),
                      Text('这里是内容这里是内容这里是内容这里是内容这里是内容',
                          style:
                              TextStyle(color: Color(0xff8a8a8a), fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1)
                    ],
                  )))
        ],
      ),
    );
  }
}
