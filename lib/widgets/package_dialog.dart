import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//添加分类的弹框
class DialogWidget extends StatefulWidget {
  final dialogCallBack;
  DialogWidget({this.dialogCallBack});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  //弹框的分类名称
  final _cateNameController = new TextEditingController();
  //是否多选多
  bool _isMulti = false;
  //可选数量
  final _numController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this._cateNameController.dispose();
    this._numController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
              child: Column(children: <Widget>[
            Container(
                height: ScreenUtil().setHeight(80),
                alignment: Alignment.center,
                child: Text('添加',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
            Divider(height: ScreenUtil().setHeight(1)),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              child: Column(children: <Widget>[
                Container(
                    constraints:
                        BoxConstraints(maxHeight: ScreenUtil().setHeight(60)),
                    child: TextField(
                      controller: this._cateNameController,
                      style: TextStyle(color: Color(0xff333333), fontSize: 16),
                      cursorColor: Color(0xff8a8a8a),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: '分类名称 如 主食',
                        hintStyle: TextStyle(fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff8a8a8a), width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff8a8a8a), width: 1)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15)),
                      ),
                    )),
                Container(
                    constraints:
                        BoxConstraints(maxHeight: ScreenUtil().setHeight(60)),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: this._isMulti,
                          activeColor: Color(0xffe25d2b),
                          onChanged: (value) {
                            this.setState(() {
                              _isMulti = value;
                            });
                          },
                        ),
                        Text(
                          '多选多',
                          style:
                              TextStyle(color: Color(0xff333333), fontSize: 16),
                        )
                      ],
                    )),
                Text(
                  '*如勾选则该分类将变为多选多的形式，如3选1，5选2等，分类名称也将自动拼接',
                  style: TextStyle(color: Color(0xffe25d2b), fontSize: 12),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                if (this._isMulti)
                  Container(
                      constraints:
                          BoxConstraints(maxHeight: ScreenUtil().setHeight(60)),
                      child: TextField(
                        controller: this._numController,
                        style:
                            TextStyle(color: Color(0xff333333), fontSize: 16),
                        cursorColor: Color(0xff8a8a8a),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '可选数量',
                          hintStyle: TextStyle(fontSize: 16),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff8a8a8a), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff8a8a8a), width: 1)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                        ),
                      )),
                if (this._isMulti) SizedBox(height: ScreenUtil().setHeight(15)),
                if (this._isMulti)
                  Text(
                    '*可选数量为该分类下菜品数量中可选的数量，如3选1中的 ‘1’',
                    style: TextStyle(color: Color(0xffe25d2b), fontSize: 12),
                  )
              ]),
            ),
            Divider(height: ScreenUtil().setHeight(1)),
            Container(
                height: ScreenUtil().setHeight(68),
                child: Row(children: <Widget>[
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Map res = {'type': 'cancel'};
                            widget.dialogCallBack(res);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '取消',
                                style: TextStyle(
                                    color: Color(0xff333333), fontSize: 14),
                              )))),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            if (this._cateNameController.text == '') {
                              print('请输入分类名称');
                            } else if (this._isMulti &&
                                this._numController.text == '') {
                              print('请输入可选数量');
                            } else {
                              List _menuList = [];
                              Map res = {
                                'type': 'confirm',
                                'cateName': this._cateNameController.text,
                                'totalNum':0,
                                'menuList':_menuList,
                                'isMulti': this._isMulti,
                                'selectNum': this._numController.text,
                              };
                              widget.dialogCallBack(res);
                            }
                          },
                          child: Container(
                              alignment: Alignment.center,
                              color: Color(0xffe25d2b),
                              child: Text('确认',
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 14)))))
                ]))
          ])),
        ));
  }
}
