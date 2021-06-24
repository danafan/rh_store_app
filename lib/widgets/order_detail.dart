import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class OrderDetail extends StatelessWidget {
  
  Map data = {};
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
                style: TextStyle(color: Color(0xff333333), fontSize: 14)),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                  'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                  height: 60,
                  width: 78,
                  fit: BoxFit.cover),
            )
          ]),
          Text('商品名称：胡晓川双人套餐',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  height: ScreenUtil().setHeight(2.8))),
          Text('商品单价：¥98.00',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  height: ScreenUtil().setHeight(2.8))),
          Text('购买数量：x1',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  height: ScreenUtil().setHeight(2.8))),
          Text('平台红包：-¥10.00',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  height: ScreenUtil().setHeight(2.8))),
          Text('积分抵扣：-¥10.00',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  height: ScreenUtil().setHeight(2.8))),
          Text('余额抵扣：-¥0.00',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  height: ScreenUtil().setHeight(2.8))),
          Text('实付金额：¥88.00',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  height: ScreenUtil().setHeight(2.8))),
          Text('付款时间：2020-08-20 13:32:48',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  height: ScreenUtil().setHeight(2.8)))
        ],
      )),
    );
  }
}
