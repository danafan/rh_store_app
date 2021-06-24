import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../service/config_tool.dart';

class OrderItem extends StatelessWidget {
  String _listType;
  OrderItem(this._listType);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
        child: Column(
          children: <Widget>[
            Container(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(23),
                            child: Image.network(
                                'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                                height: 46,
                                width: 46,
                                fit: BoxFit.cover),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(8)),
                          Text('Ranbol',
                              style: TextStyle(
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize14,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Text(_listType,
                          style: TextStyle(
                              fontSize: RhFontSize.fontSize14,
                              color: RhColors.colorDesc))
                    ])),
            Divider(height: 1),
            Container(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //套餐主图
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                          'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                          height: 80,
                          width: 104,
                          fit: BoxFit.cover),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                    //套餐内容
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('胡晓川双人套餐',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize16,
                                    fontWeight: FontWeight.bold)),
                            Text('单价：¥98.00',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('数量：x1',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('平台红包：-¥10.00',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('积分抵扣：-¥10.00',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('余额抵扣：-¥0.00',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('用户实付金额：¥88.00',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('预计收入：',
                                    style: TextStyle(
                                        color: RhColors.colorTitle,
                                        fontSize: RhFontSize.fontSize14,
                                        height: ScreenUtil().setHeight(2.8))),
                                Text('¥88.00',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: RhColors.colorPrimary,
                                        height: ScreenUtil().setHeight(2.6))),
                              ],
                            ),
                            Text('付款时间：2020-08-20 13:32:48',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('核销时间：2020-08-20 13:32:48',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('退款金额：¥88.00',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('退款时间：2020-08-20 13:32:48',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8))),
                            Text('退款原因：其他平台比这个便宜；就是不想来消费了；没时间，来不了',
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize14,
                                    height: ScreenUtil().setHeight(2.8)))
                          ],
                        ))
                  ],
                )),
            Divider(height: 1),
            Container(
                alignment: Alignment.centerLeft,
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                child: Text('钱包入账金额：¥88.00',
                    style: TextStyle(
                        fontSize: RhFontSize.fontSize14,
                        color: RhColors.colorPrimary)))
          ],
        ));
  }
}
