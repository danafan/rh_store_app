import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PackageItem extends StatelessWidget {
  String _listType;
  int _index;
  PackageItem(this._listType, this._index);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Slidable(
      key: ValueKey("$_index"),
      //配置的是右侧
      secondaryActions: secondaryActionsArray(context),
      //滑动的交互效果
      actionPane: SlidableDrawerActionPane(),
      //item内容
      child: _packageItem(),
    ));
  }

  //item内容
  _packageItem() {
    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
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
                  height: ScreenUtil().setHeight(130),
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '已售 32',
                        style:
                            TextStyle(color: Color(0xff8a8a8a), fontSize: 14),
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
                                    fontSize: 18,
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

  //右侧可滑动的部分
  List<Widget> secondaryActionsArray(context) {
    return [
      SlideAction(
        child: Container(
          color: Colors.blueGrey,
          child: Text("测试"),
        ),
      ),
      SlideAction(
        color: Colors.red,
        child: Text("测试2"),
      ),
      IconSlideAction(
        icon: Icons.add,
        color: Colors.red,
        onTap: () {
          print("点击了add");
          //主动关闭
          Slidable.of(context).close();
        },
        closeOnTap: false,
      ),
      IconSlideAction(
        //图标
        icon: Icons.home,
        //背景色
        color: Colors.orange,
        //点击事件回调
        onTap: () {
          print("点击了add");
        },
        //点击 false 不关闭 ，true关闭
        closeOnTap: false,
      )
    ];
  }
}
