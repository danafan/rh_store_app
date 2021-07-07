import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../../service/config_tool.dart';

class MessageItem extends StatefulWidget {
  final String listType;
  final Map messageItem;
  MessageItem({this.listType, this.messageItem});

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.messageItem['isRead'] == '0'
              ? Color(0x0ce25d2b)
              : RhColors.colorWhite,
          border: Border(bottom: BorderSide(color: RhColors.colorLine))),
      height: ScreenUtil().setHeight(120),
      child: Row(
        children: <Widget>[
          Container(
            color: widget.messageItem['isRead'] == '0'
                ? RhColors.colorPrimary
                : RhColors.colorWhite,
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
                    color: RhColors.colorPrimary,
                    width: ScreenUtil().setWidth(90),
                    height: ScreenUtil().setWidth(90),
                    child: Icon(
                        widget.listType == '1'
                            ? Icons.notifications
                            : Icons.volume_up,
                        color: RhColors.colorWhite),
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
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize16,
                                  fontWeight: FontWeight.bold)),
                          Text('2021-03-23 13:45:32',
                              style: TextStyle(
                                  color: RhColors.colorDesc,
                                  fontSize: RhFontSize.fontSize14))
                        ],
                      ),
                      Text('这里是内容这里是内容这里是内容这里是内容这里是内容',
                          style: TextStyle(
                              color: RhColors.colorDesc,
                              fontSize: RhFontSize.fontSize14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1)
                    ],
                  )))
        ],
      ),
    );
  }
}
