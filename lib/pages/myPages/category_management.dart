import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/dialog_widget.dart';

import '../../service/toast_tool.dart';
import '../../service/config_tool.dart';

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
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: RhColors.colorAppBar,
          brightness: Brightness.dark,
          title: Text('分类管理',
              style: TextStyle(
                  color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  showDialog<Null>(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: DialogWidget(
                            title: '新增分类',
                            content_widget: _contentWidget(),
                            cancel_fun: () {
                              this.setState(() {
                                this._nameController.text = "";
                              });
                            },
                            confirm_fun: () {
                              ToastTool.toastWidget(context, msg: '添加成功');
                              print(this._nameController.text);
                            }),
                      );
                    },
                  ).then((val) {
                    this.setState(() {
                      this._nameController.text = "";
                    });
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: RhColors.colorPrimary,
                      size: RhFontSize.fontSize16,
                    ),
                    Text(
                      '新增',
                      style: TextStyle(
                          color: RhColors.colorPrimary,
                          fontSize: RhFontSize.fontSize14),
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
            border: Border(bottom: BorderSide(color: RhColors.colorLine))),
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
                          color: RhColors.colorTitle,
                          fontSize: RhFontSize.fontSize16,
                          fontWeight: FontWeight.bold)),
                  Text('${_categoryList[index]['menu_num']}件商品',
                      style: TextStyle(
                          color: RhColors.colorPrimary,
                          fontSize: RhFontSize.fontSize14))
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
                        showDialog<Null>(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: DialogWidget(
                                  title: '编辑分类',
                                  content_widget: _contentWidget(),
                                  cancel_fun: () {
                                    this.setState(() {
                                      this._nameController.text = "";
                                    });
                                  },
                                  confirm_fun: () {
                                    //编辑
                                    print('编辑');
                                    print(this._cateId);
                                    print(this._nameController.text);
                                  }),
                            );
                          },
                        ).then((val) {
                          this.setState(() {
                            this._nameController.text = "";
                          });
                        });
                      },
                      child: Icon(Icons.border_color,
                          size: 22, color: RhColors.colorDesc),
                    ),
                    // 删除
                    InkWell(
                      onTap: () {
                        this.setState(() {
                          _cateId = _categoryList[index]['id'];
                        });
                        showDialog<Null>(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: DialogWidget(
                                  title: '提示',
                                  content_widget: Container(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(30),
                                          bottom: ScreenUtil().setHeight(30)),
                                      child: Text('确认删除该分类？')),
                                  cancel_fun: () {
                                    print('取消删除');
                                  },
                                  confirm_fun: () {
                                    ToastTool.toastWidget(context, msg: '已删除');
                                    print(this._cateId);
                                  }),
                            );
                          },
                        ).then((val) {});
                      },
                      child: Icon(Icons.delete,
                          size: 22, color: RhColors.colorDesc),
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
          style: TextStyle(color: RhColors.colorTitle, fontSize: 16),
          cursorColor: RhColors.colorDesc,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '分类名称',
            hintStyle: TextStyle(fontSize: RhFontSize.fontSize16),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: RhColors.colorDesc, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: RhColors.colorDesc, width: 1)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
          ),
        ));
  }
}
