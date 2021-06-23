import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../service/toast_tool.dart';
import '../widgets/dialog_widget.dart';

class PackageItem extends StatelessWidget {
  String _itemType;
  int _index;
  PackageItem(this._itemType, this._index);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
        child: Slidable(
          key: ValueKey("$_index"),
          //左侧滑动部分
          actions: leftActionsArray(this._itemType, context),
          //右侧滑动部分
          secondaryActions: rightActionsArray(this._itemType, context),
          //滑动的交互效果
          actionPane: SlidableDrawerActionPane(),
          //item内容
          child: _packageItem(this._itemType),
        ));
  }

  //item内容
  _packageItem(_itemType) {
    String _desc = ""; //中间提示文字
    Color _descColor = Color(0xff8a8a8a); //提示文字颜色
    if (_itemType == '1') {
      //已上架
      _desc = '已售12';
    } else if (_itemType == '2') {
      //已下架
      _desc = '已下架';
    } else if (_itemType == '3') {
      //审核通过
      _desc = '审核通过';
      _descColor = Color(0xff58BA2D);
    } else if (_itemType == '4') {
      //审核拒绝
      _desc = '审核拒绝';
      _descColor = Color(0xffEB7276);
    } else if (_itemType == '5') {
      //待审核
      _desc = '待审核';
      _descColor = Color(0xffE5A751);
    }
    return Container(
      color: Color(0xffffffff),
      child: Row(
        children: <Widget>[
          Image.network(
              'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
              height: ScreenUtil().setHeight(150),
              width: ScreenUtil().setHeight(195),
              fit: BoxFit.cover),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Expanded(
              child: Container(
                  height: ScreenUtil().setHeight(140),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '大众精选杭帮菜2选一套餐大众精选杭帮菜2选一套餐',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_desc}',
                        style: TextStyle(color: _descColor, fontSize: 14),
                      ),
                      RichText(
                          text: TextSpan(
                              text: '¥',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffe25d2b)),
                              children: <TextSpan>[
                            TextSpan(
                                text: '108  ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffe25d2b))),
                            TextSpan(
                                text: '¥198',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14,
                                    color: Color(0xff8a8a8a)))
                          ]))
                    ],
                  )))
        ],
      ),
    );
  }

  //左侧可滑动的部分
  List<Widget> leftActionsArray(_itemType, context) {
    List<Widget> _settingButton = [];
    if (_itemType == '1') {
      //已上架
      _settingButton.add(_iconSlideAction(
          Icons.vertical_align_top, '置顶', Color(0xffe25d2b), () {
        showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: DialogWidget(
                  title: '提示',
                  content_widget: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(30)),
                    child: Text('确认将该商品展示在第一位?'),
                  ),
                  cancel_fun: () {},
                  confirm_fun: () {
                    ToastTool.toastWidget(context, msg: '已置顶');
                  }),
            );
          },
        ).then((val) {});
      }));
    } else if (_itemType == '2' || _itemType == '3') {
      //已下架/审核通过
      _settingButton
          .add(_iconSlideAction(Icons.check, '上架', Color(0xffe25d2b), () {
        showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: DialogWidget(
                  title: '提示',
                  content_widget: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(30)),
                    child: Text('确认上架该商品?'),
                  ),
                  cancel_fun: () {},
                  confirm_fun: () {
                    ToastTool.toastWidget(context, msg: '已上架');
                  }),
            );
          },
        ).then((val) {});
      }));
    } else if (_itemType == '4') {
      //审核拒绝
      _settingButton
          .add(_iconSlideAction(Icons.edit, '重新编辑', Color(0xffe25d2b), () {
        Map arg = {'pageType': '2'};
        Navigator.pushNamed(context, '/created_package', arguments: arg);
      }));
    }
    return _settingButton;
  }

  //右侧可滑动的部分
  List<Widget> rightActionsArray(_itemType, context) {
    List<Widget> _settingButton = [];
    if (_itemType == '1') {
      //已上架
      _settingButton.add(_iconSlideAction(
          Icons.vertical_align_bottom, '下架', Color(0xff8a8a8a), () {
        showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: DialogWidget(
                  title: '提示',
                  content_widget: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(30)),
                    child: Text('确认下架该商品?'),
                  ),
                  cancel_fun: () {},
                  confirm_fun: () {
                    ToastTool.toastWidget(context, msg: '已下架');
                  }),
            );
          },
        ).then((val) {});
      }));
    } else if (_itemType == '2' || _itemType == '3' || _itemType == '4') {
      //已下架/审核通过/审核拒绝
      _settingButton
          .add(_iconSlideAction(Icons.delete, '删除', Color(0xff8a8a8a), () {
        showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: DialogWidget(
                  title: '提示',
                  content_widget: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(30)),
                    child: Text('确认删除该商品?'),
                  ),
                  cancel_fun: () {},
                  confirm_fun: () {
                    ToastTool.toastWidget(context, msg: '已删除');
                  }),
            );
          },
        ).then((val) {});
      }));
    } else if (_itemType == '5') {
      //待审核
      _settingButton.add(
          _iconSlideAction(Icons.keyboard_return, '撤销', Color(0xff8a8a8a), () {
        showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: DialogWidget(
                  title: '提示',
                  content_widget: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(30)),
                    child: Text('撤销后平台将不再审核该商品，并删除该商品，确认撤销?'),
                  ),
                  cancel_fun: () {},
                  confirm_fun: () {
                    ToastTool.toastWidget(context, msg: '已撤销');
                  }),
            );
          },
        ).then((val) {});
      }));
    }
    return _settingButton;
  }

  //滑动的按钮组件
  _iconSlideAction(icon, text, color, callback) {
    return IconSlideAction(
      //图标
      icon: icon,
      //文字
      caption: text,
      //背景色
      color: color,
      //点击事件回调
      onTap: callback,
      //点击 false 不关闭 ，true关闭
      closeOnTap: false,
    );
  }
}
