import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../widgets/dialog_widget.dart';

import '../../../service/toast_tool.dart';
import '../../../service/config_tool.dart';

class PackageItem extends StatelessWidget {
  final String itemType;
  final int index;
  PackageItem({this.itemType, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
        child: Slidable(
          key: ValueKey(index),
          //左侧滑动部分
          actions: leftActionsArray(this.itemType, context),
          //右侧滑动部分
          secondaryActions: rightActionsArray(this.itemType, context),
          //滑动的交互效果
          actionPane: SlidableDrawerActionPane(),
          //item内容
          child: _packageItem(this.itemType),
        ));
  }

  //item内容
  _packageItem(_itemType) {
    String _desc = ""; //中间提示文字
    Color _descColor = RhColors.colorDesc; //提示文字颜色
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
      color: RhColors.colorWhite,
      child: Row(
        children: <Widget>[
          Image.network(
              'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
              height: ScreenUtil().setHeight(130),
              width: ScreenUtil().setHeight(169),
              fit: BoxFit.cover),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Expanded(
              child: Container(
                  height: ScreenUtil().setHeight(120),
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
                            color: RhColors.colorTitle,
                            fontSize: RhFontSize.fontSize14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _desc,
                        style: TextStyle(
                            color: _descColor, fontSize: RhFontSize.fontSize12),
                      ),
                      RichText(
                          text: TextSpan(
                              text: '¥',
                              style: TextStyle(
                                  fontSize: RhFontSize.fontSize14,
                                  color: RhColors.colorPrimary),
                              children: <TextSpan>[
                            TextSpan(
                                text: '108  ',
                                style: TextStyle(
                                    fontSize: RhFontSize.fontSize16,
                                    fontWeight: FontWeight.bold,
                                    color: RhColors.colorPrimary)),
                            TextSpan(
                                text: '¥198',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: RhFontSize.fontSize14,
                                    color: RhColors.colorDesc))
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
      _showDialog(_settingButton, context, Icons.vertical_align_top, '置顶',
          RhColors.colorPrimary, '确认将该商品展示在第一位?', _itemType);
    } else if (_itemType == '2' || _itemType == '3') {
      //已下架/审核通过
      _showDialog(_settingButton, context, Icons.check, '上架',
          RhColors.colorPrimary, '确认上架该商品?', _itemType);
    } else if (_itemType == '4') {
      //审核拒绝
      _settingButton
          .add(_iconSlideAction(Icons.edit, '重新编辑', RhColors.colorPrimary, () {
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
      _showDialog(_settingButton, context, Icons.vertical_align_bottom, '下架',
          RhColors.colorDesc, '确认下架该商品?', _itemType);
    } else if (_itemType == '2' || _itemType == '3' || _itemType == '4') {
      //已下架/审核通过/审核拒绝
      _showDialog(_settingButton, context, Icons.delete, '删除',
          RhColors.colorDesc, '确认删除该商品?', _itemType);
    } else if (_itemType == '5') {
      //待审核
      _showDialog(_settingButton, context, Icons.keyboard_return, '撤销',
          RhColors.colorDesc, '撤销后平台将不再审核该商品，并删除该商品，确认撤销?', _itemType);
    }
    return _settingButton;
  }

  //可滑动的部分
  _showDialog(
      _settingButton, context, icon, caption, color, toastText, itemType) {
    _settingButton.add(_iconSlideAction(icon, caption, color, () {
      showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: DialogWidget(
                title: '提示',
                contentWidget: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(30)),
                  child: Text(toastText),
                ),
                cancelFun: () {},
                confirmFun: () {
                  Navigator.pop(context);
                  ToastTool.toastWidget(context, msg: '类型ID：$itemType');
                }),
          );
        },
      ).then((val) {});
    }));
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
