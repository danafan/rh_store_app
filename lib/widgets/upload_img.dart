import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../service/config_tool.dart';

class UploadImg extends StatefulWidget {
  final callBack;
  UploadImg({this.callBack});

  @override
  _UploadImgState createState() => _UploadImgState();
}

class _UploadImgState extends State<UploadImg> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.getImage,
        child: Container(
          color: RhColors.colorLine,
          width: ScreenUtil().setWidth(195),
          height: ScreenUtil().setWidth(150),
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.camera_alt, color: RhColors.colorDesc, size: 24),
                Text(
                  '上传图片',
                  style: TextStyle(
                      color: RhColors.colorDesc,
                      fontSize: RhFontSize.fontSize14),
                )
              ]),
        ));
  }

  //获取相册
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      widget.callBack(File(pickedFile.path));
      // this.setState(() {
      //   this._imageList.add(File(pickedFile.path));
      // });
    } else {
      print('没有选择图片');
    }
  }
}
