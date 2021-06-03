import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryManagement extends StatefulWidget {
  @override
  _CategoryManagementState createState() => _CategoryManagementState();
}

class _CategoryManagementState extends State<CategoryManagement> {
  //所有分类列表
  List _categoryList = [
    {'id': '1', 'name': '凉菜', 'menu_num': 1},
    {'id': '1', 'name': '蒸菜', 'menu_num': 2},
    {'id': '1', 'name': '主食', 'menu_num': 3}
  ];

  //分类名称
  final _nameController = new TextEditingController();

  //点击的分类ID
  String _cateId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0a0b17),
          title: Text('分类管理', style: TextStyle(fontSize: 18)),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  _dialogWidget('新增分类', _contentWidget(), () {
                    this.setState(() {
                      this._nameController.text = "";
                    });
                  }, () {
                    print('新增');
                    print(this._nameController.text);
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Color(0xffe25d2b),
                      size: 16,
                    ),
                    Text(
                      '新增',
                      style: TextStyle(color: Color(0xffe25d2b), fontSize: 14),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(30))
                  ],
                ))
          ]),
      body: ListView.builder(
          padding: EdgeInsets.only(left: 8, right: 8),
          itemCount: this._categoryList.length,
          itemBuilder: (context, index) {
            return _cateItemWidget(index);
          }),
    );
  }

  //某一个分类
  _cateItemWidget(index) {
    return Container(
        height: ScreenUtil().setHeight(110),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffF1F6F9)))),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text('${_categoryList[index]['name']}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text('${_categoryList[index]['menu_num']}件商品',
                      style: TextStyle(color: Color(0xffe25d2b), fontSize: 14))
                ])),
            Container(
                width: ScreenUtil().setWidth(180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // 编辑
                    InkWell(
                      onTap: () {
                        this.setState(() {
                          _cateId = _categoryList[index]['id'];
                          this._nameController.text =
                              _categoryList[index]['name'];
                        });
                        _dialogWidget('编辑分类', _contentWidget(), () {
                          this.setState(() {
                            this._nameController.text = "";
                          });
                        }, () {
                          //编辑
                          print('编辑');
                          print(this._cateId);
                          print(this._nameController.text);
                        });
                      },
                      child: Icon(Icons.border_color,
                          size: 22, color: Color(0xff8a8a8a)),
                    ),
                    // 删除
                    InkWell(
                      onTap: () {
                        this.setState(() {
                          _cateId = _categoryList[index]['id'];
                        });
                        _dialogWidget(
                            '提示',
                            Container(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(30),
                                    bottom: ScreenUtil().setHeight(30)),
                                child: Text('确认删除该分类？')), () {
                          print('取消删除');
                        }, () {
                          //删除
                          print('删除');
                          print(this._cateId);
                        });
                      },
                      child: Icon(Icons.delete,
                          size: 22, color: Color(0xff8a8a8a)),
                    ),
                  ],
                ))
          ],
        ));
  }

  //编辑和分类的中间组件
  _contentWidget() {
    return Container(
        constraints: BoxConstraints(maxHeight: ScreenUtil().setHeight(60)),
        child: TextField(
          controller: this._nameController,
          style: TextStyle(color: Color(0xff333333), fontSize: 16),
          cursorColor: Color(0xff8a8a8a),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '分类名称',
            hintStyle: TextStyle(fontSize: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff8a8a8a), width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff8a8a8a), width: 1)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
          ),
        ));
  }

  //弹框组件
  _dialogWidget(title, content_widget, cancel_fun, confirm_fun) {
    return showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Container(
                    height: ScreenUtil().setHeight(80),
                    alignment: Alignment.center,
                    child: Text(title,
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
                Divider(height: ScreenUtil().setHeight(1)),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                  child: content_widget,
                ),
                Divider(height: ScreenUtil().setHeight(1)),
                Container(
                    height: ScreenUtil().setHeight(68),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                cancel_fun();
                                Navigator.of(context).pop();
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
                                confirm_fun();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffe25d2b),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5))),
                                  alignment: Alignment.center,
                                  child: Text('确认',
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 14)))))
                    ]))
              ]))),
        );
      },
    ).then((val) {
      cancel_fun();
    });
  }
}
