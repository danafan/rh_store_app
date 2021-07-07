import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../../service/config_tool.dart';

class OrderDetail extends StatelessWidget {
  final Map data;
  OrderDetail({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //套餐主图
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text('商品主图：',
                style: TextStyle(
                    color: RhColors.colorTitle,
                    fontSize: RhFontSize.fontSize14)),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                  'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                  height: ScreenUtil().setHeight(110),
                  width: ScreenUtil().setHeight(143),
                  fit: BoxFit.cover),
            )
          ]),
          _textRow('商品名称：胡晓川双人套餐'),
          _textRow('商品单价：¥98.00'),
          _textRow('购买数量：x1'),
          _textRow('平台红包：-¥10.00'),
          _textRow('积分抵扣：-¥10.00'),
          _textRow('余额抵扣：-¥0.00'),
          _textRow('实付金额：¥88.00'),
          _textRow('付款时间：2020-08-20 13:32:48')
        ],
      )),
    );
  }

  //每一行文字
  _textRow(text) {
    return Text(text,
        style: TextStyle(
            color: RhColors.colorTitle, fontSize: RhFontSize.fontSize14));
  }
}
