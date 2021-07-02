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
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(23),
                            child: Image.network(
                                'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                                height: ScreenUtil().setWidth(80),
                                width: ScreenUtil().setWidth(80),
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
                          height: ScreenUtil().setHeight(110),
                          width: ScreenUtil().setHeight(143),
                          fit: BoxFit.cover),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                    //套餐内容
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _textRow('胡晓川双人套餐'),
                            _textRow('单价：¥98.00'),
                            _textRow('数量：x1'),
                            _textRow('平台红包：-¥10.00'),
                            _textRow('积分抵扣：-¥10.00'),
                            _textRow('余额抵扣：-¥0.00'),
                            _textRow('用户实付金额：¥88.00'),
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
                            _textRow('付款时间：2020-08-20 13:32:48'),
                            _textRow('核销时间：2020-08-20 13:32:48'),
                            _textRow('退款金额：¥88.00'),
                            _textRow('退款时间：2020-08-20 13:32:48'),
                            _textRow('退款原因：其他平台比这个便宜；就是不想来消费了；没时间，来不了')
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

  //每一行文字
  _textRow(text) {
    return Text(text,
        style: TextStyle(
            color: RhColors.colorTitle,
            fontSize: RhFontSize.fontSize14));
  }
}
