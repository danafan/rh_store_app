import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:rh_store_app/widgets/button_widget.dart';

import '../../service/config_tool.dart';

class Complaint extends StatefulWidget {
  final Map arguments;
  Complaint({this.arguments});
  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  String _id = ''; //评价id

  //可选列表
  List<String> _factorsList = [
    '同行恶意差评',
    '用户选错评分',
    '用户提出不合理要求',
    '用户以差评威胁商家',
    '广告或无意义评价',
    '其它'
  ];
  //当前选中的因素
  int _currentIndex;

  //申诉内容
  final _complaintCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    this._id = widget.arguments['id'];
  }

  @override
  void dispose() {
    this._complaintCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RhColors.colorAppBar,
        brightness: Brightness.dark,
        title: Text('评价申诉',
            style: TextStyle(
                color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
      ),
      body: SingleChildScrollView(
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  _topToast(),
                  _titleWidget(),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20)),
                    color: RhColors.colorWhite,
                    child: Column(children: <Widget>[
                      Column(
                        children:
                            this._factorsList.asMap().keys.map<Widget>((index) {
                          return _optionWidget(index);
                        }).toList(),
                      ),
                      SizedBox(height: ScreenUtil().setWidth(20)),
                      TextField(
                        maxLines: 3,
                        maxLength: 120,
                        controller: this._complaintCon,
                        decoration: InputDecoration(
                            hintText: '申诉补充文字，最多120字...',
                            hintStyle:
                                TextStyle(fontSize: RhFontSize.fontSize14),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(12)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: RhColors.colorDesc),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: RhColors.colorDesc),
                            )),
                      )
                    ]),
                  ),
                  SizedBox(height: ScreenUtil().setWidth(20)),
                  ButtonWidget(
                      text: '提交',
                      buttonBack: () {
                        print(this._id);
                        print('提交');
                      })
                ],
              ))),
    );
  }

  //顶部提示
  _topToast() {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Color(0x0ce25d2b),
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      child: Text(
        '温馨提示：为保障商家和用户的权益，热乎优选平台专门设立了评价处理团队。商家提交申诉请认真如实选择申诉原因，也可补充文字描述。申诉通过后平台将立即删除该条评论并恢复商家评分。如经核实商家申诉原因不属实，将影响商家信用度和商家排名',
        style: TextStyle(
            color: RhColors.colorPrimary, fontSize: RhFontSize.fontSize14),
      ),
    );
  }

  //标题
  _titleWidget() {
    return Container(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
        alignment: Alignment.centerLeft,
        height: ScreenUtil().setHeight(100),
        child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: '申诉原因',
                style: TextStyle(
                    color: RhColors.colorTitle,
                    fontSize: RhFontSize.fontSize18,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: '(也可补充文字描述)',
                style: TextStyle(
                    color: RhColors.colorDesc, fontSize: RhFontSize.fontSize14))
          ]),
        ));
  }

  //选项item
  _optionWidget(index) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        this.setState(() {
          if (this._currentIndex == index) {
            _currentIndex = null;
          } else {
            _currentIndex = index;
          }
        });
      },
      child: Container(
        height: ScreenUtil().setHeight(90),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: RhColors.colorLine))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${this._factorsList[index]}',
                style: TextStyle(
                    fontSize: RhFontSize.fontSize14,
                    color: RhColors.colorTitle),
              ),
              Icon(
                this._currentIndex == index
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
                size: 20,
                color: this._currentIndex == index
                    ? RhColors.colorPrimary
                    : RhColors.colorDesc,
              )
            ]),
      ),
    );
  }
}
