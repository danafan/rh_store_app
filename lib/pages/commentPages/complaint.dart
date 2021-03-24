import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:rh_store_app/widgets/button_widget.dart';

class Complaint extends StatefulWidget {
  Map arguments;
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
  int _currentIndex = null;

  //申诉内容
  final _complaintCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._id = widget.arguments['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('评价申诉'),
      ),
      body: ListView(
        children: <Widget>[
          _topToast(),
          _titleWidget(),
          Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setWidth(20)
                ),
            color: Colors.white,
            child: Column(children: <Widget>[
              Column(
                children: this._factorsList.asMap().keys.map<Widget>((index) {
                  return _optionWidget(index);
                }).toList(),
              ),
              SizedBox(height:ScreenUtil().setWidth(20)),
              TextField(
                maxLines: 3,
                style: TextStyle(),
                maxLength: 120,
                controller: this._complaintCon,
                decoration: InputDecoration(
                    hintText: '请输入申诉内容，最多120字',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff8a8a8a)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff8a8a8a)),
                    )),
              )
            ]),
          ),
          SizedBox(height:ScreenUtil().setWidth(20)),
          ButtonWidget(text:'提交',buttonBack:(){
            print('提交');
          })
        ],
      ),
    );
  }

  //顶部提示
  _topToast() {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Color(0xffFBE8E2),
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      child: Text(
        '温馨提示：为保障商家和用户的权益，热乎优选平台专门设立了评价处理团队。商家提交申诉请认真如是选择申诉原因，也可增加文字描述。申诉通过后平台将立即删除该条评论并恢复商家评分。如经核实商家申诉原因不属实，将影响商家信用度和商家排名',
        style: TextStyle(color: Color(0xff8E302C), fontSize: 14),
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
          text: TextSpan(
              text: '申诉原因 ',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: '(也可添加文字描述)',
                    style: TextStyle(color: Color(0xff8a8a8a), fontSize: 15))
              ]),
        ));
  }

  //选项item
  _optionWidget(index) {
    return Container(
      height: ScreenUtil().setHeight(90),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffF9F9F9)))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${this._factorsList[index]}',
              style: TextStyle(fontSize: 15, color: Color(0xff333333)),
            ),
            InkWell(
                onTap: () {
                  this.setState(() {
                    if (this._currentIndex == index) {
                      _currentIndex = null;
                    } else {
                      _currentIndex = index;
                    }
                  });
                },
                child: Icon(
                  this._currentIndex == index
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  size: 20,
                  color: this._currentIndex == index
                      ? Theme.of(context).primaryColor
                      : Color(0xff8a8a8a),
                ))
          ]),
    );
  }
}
