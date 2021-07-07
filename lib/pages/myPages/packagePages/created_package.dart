import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import './package_dialog.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/upload_img.dart';

import '../../../service/toast_tool.dart';
import '../../../service/config_tool.dart';

class CreatedPackage extends StatefulWidget {
  final Map arguments;
  CreatedPackage({this.arguments});
  @override
  _CreatedPackageState createState() => _CreatedPackageState();
}

class _CreatedPackageState extends State<CreatedPackage> {
  String _pageType = ""; //来源页面(1:新建；2:编辑)
  //名称
  final _nameController = new TextEditingController();
  //套餐内容列表
  List _packageList = [];
  //价格
  final _priceController = new TextEditingController();
  //备注
  final _remarkController = new TextEditingController();
  //审核通过后是否直接上架
  bool _isShelves = true;
  //上传的图片列表
  List _imageList = [];
  final picker = ImagePicker();
  //所有分类列表
  List _cateList = [
    {'id': '1', 'name': '主食'},
    {'id': '2', 'name': '凉菜'},
    {'id': '3', 'name': '凉菜'},
    {'id': '4', 'name': '凉菜'},
    {'id': '5', 'name': '凉菜'},
    {'id': '6', 'name': '凉菜'},
    {'id': '7', 'name': '凉菜'},
    {'id': '8', 'name': '凉菜'},
    {'id': '9', 'name': '热菜'}
  ];
  //选中的分类下标
  int _activeCateIndex = 0;
  //所有菜品列表
  List _menuList = [
    {'id': '1', 'name': '老坛酸菜鱼', 'price': 48, 'num': 1, 'unit': '份'},
    {'id': '2', 'name': '青椒肉丝', 'price': 22, 'num': 1, 'unit': '碗'},
    {'id': '3', 'name': '小炒肉', 'price': 18, 'num': 1, 'unit': '盆'}
  ];
  //选中的菜品下标
  int _activeMenuIndex;

  @override
  void initState() {
    super.initState();
    this._pageType = widget.arguments['pageType'];
  }

  @override
  void dispose() {
    this._nameController.dispose();
    this._priceController.dispose();
    this._remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: RhColors.colorAppBar,
          brightness: Brightness.dark,
          title: Text(
            '${this._pageType == '1' ? '新建' : '编辑'}套餐',
            style: TextStyle(
                color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18),
          )),
      body: SingleChildScrollView(
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                  color: RhColors.colorWhite,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15)),
                  child: Column(children: <Widget>[
                    //名称
                    Container(
                        height: ScreenUtil().setHeight(90),
                        child: Row(children: <Widget>[
                          _labelTitle('名称'),
                          Expanded(
                              child: TextField(
                            controller: this._nameController,
                            style: TextStyle(
                                color: RhColors.colorTitle,
                                fontSize: RhFontSize.fontSize16),
                            cursorColor: RhColors.colorDesc,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: '套餐名称，30字以内...',
                              hintStyle: TextStyle(
                                  fontSize: RhFontSize.fontSize16,
                                  color: RhColors.colorDesc),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(15)),
                            ),
                          ))
                        ])),
                    Divider(height: 1),
                    //图片
                    SingleChildScrollView(
                      child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            _labelTitle('图片'),
                            SizedBox(width: ScreenUtil().setWidth(15)),
                            Expanded(
                                child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                  SizedBox(height: ScreenUtil().setHeight(25)),
                                  Wrap(
                                    spacing: ScreenUtil().setWidth(15),
                                    runSpacing: ScreenUtil().setWidth(15),
                                    children: this
                                        ._imageList
                                        .map<Widget>(
                                            (e) => this._imageWidget(e))
                                        .toList(),
                                  ),
                                  this._imageList.length < 5
                                      ? UploadImg(callBack: (_imgFile) {
                                          this.setState(() {
                                            this._imageList.add(_imgFile);
                                          });
                                        })
                                      : SizedBox(height: 0),
                                  SizedBox(height: ScreenUtil().setHeight(15)),
                                  Text('*最多5张，建议图片比例1:1.3',
                                      style: TextStyle(
                                          color: RhColors.colorPrimary,
                                          fontSize: RhFontSize.fontSize12)),
                                  Text('默认第一张为封面图，长按可切换或删除',
                                      style: TextStyle(
                                          color: RhColors.colorPrimary,
                                          fontSize: RhFontSize.fontSize12)),
                                  SizedBox(height: ScreenUtil().setHeight(15))
                                ])))
                          ])),
                    ),
                    Divider(height: 1),
                    // 内容
                    SingleChildScrollView(
                      child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            _labelTitle('内容'),
                            SizedBox(width: ScreenUtil().setWidth(15)),
                            Expanded(
                                child: Container(
                                    child: Column(children: <Widget>[
                              _addCateWidget(),
                              _cateBox(),
                              if (this._packageList.length > 0)
                                SizedBox(height: ScreenUtil().setHeight(15))
                            ])))
                          ])),
                    ),
                    Divider(height: 1),
                    // 价格
                    Container(
                        height: ScreenUtil().setHeight(90),
                        child: Row(children: <Widget>[
                          _labelTitle('价格'),
                          SizedBox(
                            width: ScreenUtil().setWidth(10),
                          ),
                          Text('¥',
                              style: TextStyle(
                                  color: RhColors.colorPrimary,
                                  fontSize: RhFontSize.fontSize16)),
                          Expanded(
                              child: TextField(
                            controller: this._priceController,
                            style: TextStyle(
                                color: RhColors.colorTitle,
                                fontSize: RhFontSize.fontSize16),
                            cursorColor: RhColors.colorPrimary,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '输入用户购买的价格',
                              hintStyle:
                                  TextStyle(fontSize: RhFontSize.fontSize16),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(15)),
                            ),
                          ))
                        ])),
                    Divider(height: 1),
                    // 审核后直接上架
                    Container(
                        height: ScreenUtil().setHeight(90),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('审核通过后直接上架',
                                  style: TextStyle(
                                      color: RhColors.colorTitle,
                                      fontSize: RhFontSize.fontSize16)),
                              Switch(
                                  value: this._isShelves,
                                  activeColor: RhColors.colorPrimary,
                                  onChanged: (value) {
                                    this.setState(() {
                                      _isShelves = value;
                                    });
                                  })
                            ])),
                    Divider(height: 1),
                    // 备注
                    Container(
                        height: ScreenUtil().setHeight(180),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('备注',
                                  style: TextStyle(
                                      color: RhColors.colorTitle,
                                      fontSize: RhFontSize.fontSize16)),
                              Expanded(
                                  child: TextField(
                                controller: this._remarkController,
                                style: TextStyle(
                                    color: RhColors.colorTitle,
                                    fontSize: RhFontSize.fontSize16),
                                cursorColor: RhColors.colorPrimary,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: '用于特殊说明，展示在用户端套餐内容下面，不超过120字...',
                                  hintStyle: TextStyle(
                                      fontSize: RhFontSize.fontSize16),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(15)),
                                ),
                              ))
                            ])),
                    Divider(height: 1),
                    SizedBox(height: ScreenUtil().setHeight(50)),
                    ButtonWidget(
                        text: '提交',
                        buttonBack: () {
                          final _moneyRegExp = new RegExp(
                              r'^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$');
                          if (this._nameController.text == '') {
                            ToastTool.toastWidget(context, msg: '请输入套餐名称');
                          } else if (this._imageList.length == 0) {
                            ToastTool.toastWidget(context, msg: '至少上传一张图片');
                          } else if (this._packageList.length == 0) {
                            ToastTool.toastWidget(context, msg: '至少上传一个商品');
                          } else if (this._priceController.text == '') {
                            ToastTool.toastWidget(context, msg: '请输入购买价格');
                          } else if (!_moneyRegExp
                              .hasMatch(this._priceController.text)) {
                            ToastTool.toastWidget(context,
                                msg: '价格需大于0且最多两位小数');
                          } else {
                            print('已成功');
                          }
                        }),
                    SizedBox(height: ScreenUtil().setHeight(50)),
                  ])))),
    );
  }

  //点击添加分类
  _addCateWidget() {
    return Container(
      alignment: Alignment.centerRight,
      height: ScreenUtil().setHeight(90),
      child: InkWell(
        onTap: () {
          List _menuList = [];
          Map _packageItem = {
            'type': 'confirm',
            'cateName': '',
            'totalNum': 0,
            'menuList': _menuList,
            'isMulti': false,
            'selectNum': ""
          };
          showDialog<Null>(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: DialogWidget(
                    packageItem: _packageItem,
                    dialogCallBack: (res) {
                      //点击弹框确认
                      if (res['type'] == 'confirm') {
                        this.setState(() {
                          _packageList.add(res);
                        });
                      }
                      Navigator.of(context).pop();
                    }),
              );
            },
          ).then((val) {
            print('弹框关闭');
          });
        },
        child: Container(
          width: ScreenUtil().setWidth(130),
          height: ScreenUtil().setHeight(42),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: RhColors.colorPrimary,
              borderRadius: BorderRadius.circular(ScreenUtil().setHeight(21))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.control_point, color: RhColors.colorWhite, size: 16),
              SizedBox(width: 3),
              Text(
                '添加',
                style: TextStyle(
                    color: RhColors.colorWhite,
                    fontSize: RhFontSize.fontSize14),
              )
            ],
          ),
        ),
      ),
    );
  }

  //已填写的分类和菜品的框
  _cateBox() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
        color: RhColors.colorLine,
        child: Column(children: <Widget>[
          Column(
              children: this
                  ._packageList
                  .asMap()
                  .keys
                  .map<Widget>((i) => this._cateMenuItem(i))
                  .toList()),
          if (this._packageList.length > 0) this._totalPriceWidget()
        ]));
  }

  //某一个分类和商品
  _cateMenuItem(i) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 分类名称
            Container(
                height: ScreenUtil().setHeight(68),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Map _packageItem = {
                          'type': 'confirm',
                          'cateName': this._packageList[i]['cateName'],
                          'totalNum': this._packageList[i]['totalNum'],
                          'menuList': this._packageList[i]['menuList'],
                          'isMulti': this._packageList[i]['isMulti'],
                          'selectNum': this._packageList[i]['selectNum'],
                        };
                        showDialog<Null>(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: DialogWidget(
                                  packageItem: _packageItem,
                                  dialogCallBack: (res) {
                                    //点击弹框确认
                                    if (res['type'] == 'confirm') {
                                      this.setState(() {
                                        _packageList[i] = res;
                                      });
                                    }
                                    Navigator.of(context).pop();
                                  }),
                            );
                          },
                        ).then((val) {
                          print('弹框关闭');
                        });
                      },
                      child: Text(
                        this._packageList[i]['isMulti']
                            ? '${this._packageList[i]['cateName']}（${this._packageList[i]['totalNum']}选${this._packageList[i]['selectNum']}）'
                            : '${this._packageList[i]['cateName']}',
                        style: TextStyle(
                            color: RhColors.colorTitle,
                            fontSize: RhFontSize.fontSize14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          this.setState(() {
                            this._packageList.removeAt(i);
                          });
                        },
                        child: Icon(Icons.do_not_disturb_on,
                            size: 24, color: Color(0xffd81e06)))
                  ],
                )),
            // 所有菜品列表
            Column(
                children: this
                    ._packageList[i]['menuList']
                    .asMap()
                    .keys
                    .map<Widget>((index) => Container(
                        padding: EdgeInsetsDirectional.only(
                            bottom: ScreenUtil().setHeight(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.lens,
                                    color: RhColors.colorDesc, size: 10),
                                SizedBox(width: ScreenUtil().setWidth(10)),
                                Text(
                                  "${this._packageList[i]['menuList'][index]['name']}",
                                  style: TextStyle(
                                      color: RhColors.colorDesc,
                                      fontSize: RhFontSize.fontSize14),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                      this._editMenuNum(i, index, '1');
                                    },
                                    child: Icon(Icons.remove_circle_outline,
                                        color: RhColors.colorPrimary,
                                        size: 20)),
                                SizedBox(width: ScreenUtil().setWidth(6)),
                                Text(
                                  "${this._packageList[i]['menuList'][index]['num']}${this._packageList[i]['menuList'][index]['unit']}",
                                  style: TextStyle(
                                      color: RhColors.colorDesc,
                                      fontSize: RhFontSize.fontSize14),
                                ),
                                SizedBox(width: ScreenUtil().setWidth(6)),
                                InkWell(
                                    onTap: () {
                                      this._editMenuNum(i, index, '2');
                                    },
                                    child: Icon(Icons.add_circle,
                                        color: RhColors.colorPrimary,
                                        size: 20)),
                              ],
                            )
                          ],
                        )))
                    .toList()),
            // 添加菜品下拉框
            InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    enableDrag: false, //设置不能拖拽关闭
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Container(
                          height: ScreenUtil().setHeight(500),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              //底部弹款分类列表
                              _categoryWidget(state),
                              //底部弹款显示分类下菜品列表
                              _menulistWidget(state, i)
                            ],
                          ),
                        );
                      });
                    },
                  );
                },
                child: Container(
                    child: Row(children: <Widget>[
                  Text('添加菜品',
                      style: TextStyle(
                          color: RhColors.colorPrimary,
                          fontSize: RhFontSize.fontSize14)),
                  Icon(Icons.add,
                      size: RhFontSize.fontSize16, color: RhColors.colorPrimary)
                ])))
          ]),
    );
  }

  //底部弹款分类列表
  _categoryWidget(state) {
    return Container(
        color: RhColors.colorLine,
        width: ScreenUtil().setWidth(220),
        child: ListView.builder(
            itemCount: this._cateList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    state(() {
                      _activeCateIndex = index;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: RhColors.colorWhite))),
                      height: ScreenUtil().setHeight(70),
                      alignment: Alignment.center,
                      child: Text(
                        this._cateList[index]['name'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: this._activeCateIndex == index
                                ? RhColors.colorPrimary
                                : RhColors.colorTitle,
                            fontSize: RhFontSize.fontSize16,
                            fontWeight: FontWeight.bold),
                      )));
            }));
  }

  //底部弹框显示分类下菜品列表
  _menulistWidget(state, i) {
    return Expanded(
        child: Container(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8),
                itemCount: this._menuList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        bool _isHave = false;
                        int _listI;
                        for (var id = 0;
                            id < _packageList[i]['menuList'].length;
                            id++) {
                          if (this._menuList[index]['id'] ==
                              _packageList[i]['menuList'][id]['id']) {
                            _isHave = true;
                            _listI = id;
                          }
                        }
                        //修改全局的状态
                        this.setState(() {
                          _activeMenuIndex = index;
                          if (_isHave) {
                            _packageList[i]['menuList'][_listI]['num'] += 1;
                          } else {
                            Map ff = {
                              'id': this._menuList[index]['id'],
                              'name': this._menuList[index]['name'],
                              'price': this._menuList[index]['price'],
                              'num': this._menuList[index]['num'],
                              'unit': this._menuList[index]['unit']
                            };
                            _packageList[i]['menuList'].add(ff);
                          }
                          _packageList[i]['totalNum'] =
                              _packageList[i]['menuList'].length;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: RhColors.colorLine))),
                          height: ScreenUtil().setHeight(70),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(this._menuList[index]['name'],
                                  style: TextStyle(
                                      color: this._activeMenuIndex == index
                                          ? RhColors.colorPrimary
                                          : RhColors.colorTitle,
                                      fontSize: RhFontSize.fontSize14)),
                              Text('¥${this._menuList[index]['price']}',
                                  style: TextStyle(
                                      color: this._activeMenuIndex == index
                                          ? RhColors.colorPrimary
                                          : RhColors.colorTitle,
                                      fontSize: RhFontSize.fontSize14))
                            ],
                          )));
                })));
  }

  //合计组件
  _totalPriceWidget() {
    return Container(
        height: ScreenUtil().setHeight(68),
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '合计：¥',
                style: TextStyle(
                  color: RhColors.colorTitle,
                  fontSize: RhFontSize.fontSize14,
                ),
              ),
              TextSpan(
                text: '${_totalFun()}',
                style: TextStyle(
                    color: RhColors.colorTitle,
                    fontSize: RhFontSize.fontSize18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  //计算总金额
  _totalFun() {
    int _totalPirce = 0;
    for (var i = 0; i < _packageList.length; i++) {
      int _itemTotal = 0;
      if (_packageList[i]['menuList'].length > 0) {
        //多选多
        if (_packageList[i]['isMulti']) {
          List _numArr = [];
          for (var index = 0;
              index < _packageList[i]['menuList'].length;
              index++) {
            _numArr.add((_packageList[i]['menuList'][index]['price'] *
                _packageList[i]['menuList'][index]['num']));
          }
          _numArr.sort((num1, num2) => num2 - num1);
          List _takeArr =
              _numArr.take(int.parse(_packageList[i]['selectNum'])).toList();
          for (var take_i = 0; take_i < _takeArr.length; take_i++) {
            _itemTotal += _takeArr[take_i];
          }
        } else {
          for (var index = 0;
              index < _packageList[i]['menuList'].length;
              index++) {
            _itemTotal += (_packageList[i]['menuList'][index]['price'] *
                _packageList[i]['menuList'][index]['num']);
          }
        }
      }
      _totalPirce += _itemTotal;
    }
    return _totalPirce;
  }

  //每一行的label
  _labelTitle(title) {
    return Container(
      height: ScreenUtil().setHeight(90),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
            text: '*',
            style: TextStyle(
                fontSize: RhFontSize.fontSize16,
                fontWeight: FontWeight.bold,
                color: RhColors.colorPrimary),
            children: <TextSpan>[
              TextSpan(
                  text: title, style: TextStyle(color: RhColors.colorTitle)),
            ]),
      ),
    );
  }

  //图片组件
  _imageWidget(imageUrl) {
    return GestureDetector(
      child: Image.file(
        imageUrl,
        width: ScreenUtil().setWidth(195),
        height: ScreenUtil().setWidth(150),
        fit: BoxFit.cover,
      ),
      onTap: () {
        var arg = {'images': this._imageList, 'index': 0, 'heroTag': '111'};
        Navigator.pushNamed(context, '/photo_view', arguments: arg);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          enableDrag: false, //设置不能拖拽关闭
          builder: (BuildContext context) {
            return Container(
              height: ScreenUtil().setHeight(220),
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        print(this._imageList);
                        print(imageUrl);
                        this.setState(() {
                          this._imageList.remove(imageUrl);
                          this._imageList.insert(0, imageUrl);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: ScreenUtil().setHeight(58),
                          alignment: Alignment.center,
                          child: Text('设为封面',
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: 16)))),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  InkWell(
                      onTap: () {
                        this.setState(() {
                          this._imageList.remove(imageUrl);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: ScreenUtil().setHeight(58),
                          alignment: Alignment.center,
                          child: Text('删除',
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: 16)))),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: ScreenUtil().setHeight(50),
                          alignment: Alignment.center,
                          child: Text('取消',
                              style: TextStyle(
                                  color: Color(0xffe25d2b), fontSize: 16)))),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //修改某菜品的数量
  _editMenuNum(i, index, type) {
    this.setState(() {
      if (type == '1') {
        if (this._packageList[i]['menuList'][index]['num'] > 1) {
          this._packageList[i]['menuList'][index]['num'] -= 1;
        } else {
          this._packageList[i]['menuList'].removeAt(index);
        }
      }
      if (type == '2') {
        this._packageList[i]['menuList'][index]['num'] += 1;
      }
      _packageList[i]['totalNum'] = _packageList[i]['menuList'].length;
    });
  }
}
