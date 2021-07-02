import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../service/toast_tool.dart';
import '../service/config_tool.dart';

class CommentItem extends StatefulWidget {
  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  //回复内容
  final _replyValue = TextEditingController();

  @override
  void dispose() {
    _replyValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: RhColors.colorWhite, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          // 顶部用户信息等
          Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: Image.network(
                            'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                            height: ScreenUtil().setWidth(80),
                            width: ScreenUtil().setWidth(80),
                            fit: BoxFit.cover),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(18)),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '伪装的幸福',
                              style: TextStyle(
                                  color: RhColors.colorTitle,
                                  fontSize: RhFontSize.fontSize14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.grade,
                                    size: 18, color: RhColors.colorPrimary),
                                Icon(Icons.grade,
                                    size: 18, color: RhColors.colorPrimary),
                                Icon(Icons.grade,
                                    size: 18, color: RhColors.colorPrimary)
                              ],
                            )
                          ])
                    ]),
                    Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: <Widget>[
                          Text('2020-08-29',
                              style: TextStyle(
                                  color: RhColors.colorDesc,
                                  fontSize: RhFontSize.fontSize14)),
                          Positioned(
                              top: ScreenUtil().setHeight(5),
                              child: Container(
                                  width: 50,
                                  height: 30,
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationZ(-0.3),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xffE6485F), width: 2)),
                                  child: Text('优质',
                                      style: TextStyle(
                                          color: Color(0xffE6485F),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))))
                        ])
                  ])),
          //评论的文字
          Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Text(
                '3月18日，西安市报告1例本土确诊病例。该确诊病例为西安市第八医院封闭隔离病区检验师。经省市专家组初步研判，该病例系在封闭隔离病区内意外暴露造成偶发感染',
                style: TextStyle(
                  color: RhColors.colorTitle,
                  fontSize: RhFontSize.fontSize14,
                ),
              )),
          //评论的图片
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      var arg = {
                        'images': [
                          'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                          'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg'
                        ],
                        'index': 0,
                        'heroTag': '111'
                      };
                      Navigator.pushNamed(context, '/photo_view',
                          arguments: arg);
                    },
                    child: Image.network(
                        'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                        height: ScreenUtil().setWidth(180),
                        width: ScreenUtil().setWidth(180),
                        fit: BoxFit.cover)),
                Image.network(
                    'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                    height: ScreenUtil().setWidth(180),
                    width: ScreenUtil().setWidth(180),
                    fit: BoxFit.cover),
                Image.network(
                    'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                    height: ScreenUtil().setWidth(180),
                    width: ScreenUtil().setWidth(180),
                    fit: BoxFit.cover),
                Image.network(
                    'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                    height: ScreenUtil().setWidth(180),
                    width: ScreenUtil().setWidth(180),
                    fit: BoxFit.cover)
              ],
            ),
          ),
          // 购买的商品
          Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text('好得火锅2人烤鱼套餐好得火锅',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: RhColors.colorDesc,
                              fontSize: RhFontSize.fontSize14))),
                  SizedBox(width: 20),
                  Text('x1',
                      style: TextStyle(
                          color: RhColors.colorDesc,
                          fontSize: RhFontSize.fontSize14)),
                ],
              )),
          //商家回复
          Container(
              decoration: BoxDecoration(color: RhColors.colorLine),
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: RhFontSize.fontSize14),
                  children: <TextSpan>[
                    TextSpan(
                        text: '商家回复：',
                        style: TextStyle(color: RhColors.colorPrimary)),
                    TextSpan(
                        text: '感谢您的支持！好的火锅全体工作人员祝您生活愉快!',
                        style: TextStyle(color: RhColors.colorDesc)),
                  ],
                ),
              )),
          //底部操作
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Map arg = {'id': '1'};
                    //申诉
                    Navigator.pushNamed(context, '/complaint', arguments: arg);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.error_outline,
                        size: 14,
                      ),
                      Text('申诉',
                          style: TextStyle(
                              color: RhColors.colorTitle,
                              fontSize: RhFontSize.fontSize14))
                    ],
                  )),
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      enableDrag: false, //设置不能拖拽关闭
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                constraints: BoxConstraints(
                                    minHeight: ScreenUtil().setHeight(50),
                                    maxHeight: ScreenUtil().setHeight(150)),
                                child: TextField(
                                  maxLines: null,
                                  autofocus: true,
                                  controller: this._replyValue,
                                  decoration: InputDecoration(
                                      hintText: '最多120字',
                                      hintStyle: TextStyle(
                                          fontSize: RhFontSize.fontSize14),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(
                                          ScreenUtil().setWidth(12)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: RhColors.colorDesc),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: RhColors.colorDesc),
                                      )),
                                ),
                              )),
                              SizedBox(width: 5),
                              InkWell(
                                  onTap: () {
                                    ToastTool.toastWidget(context, msg: '已回复');
                                  },
                                  child: Container(
                                      height: ScreenUtil().setHeight(50),
                                      width: ScreenUtil().setWidth(110),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xff4BB84F),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Text('回复',
                                          style: TextStyle(
                                              color: RhColors.colorWhite,
                                              fontSize:
                                                  RhFontSize.fontSize14))))
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(42),
                      width: ScreenUtil().setWidth(110),
                      decoration: BoxDecoration(
                          border: Border.all(color: RhColors.colorDesc),
                          borderRadius: BorderRadius.circular(21)),
                      child: Text(
                        '回复',
                        style: TextStyle(
                            color: RhColors.colorDesc,
                            fontSize: RhFontSize.fontSize14),
                      )))
            ],
          ))
        ]));
  }
}
