import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button_widget.dart';
import '../widgets/upload_img.dart';
import '../widgets/row_widget.dart';
import '../widgets/text_field.dart';
import '../widgets/image_widget.dart';

import '../service/toast_tool.dart';
import '../service/config_tool.dart';

class IntoCertificate extends StatefulWidget {
  @override
  _IntoCertificateState createState() => _IntoCertificateState();
}

class _IntoCertificateState extends State<IntoCertificate> {
  //商家名称
  final _storeNameController = new TextEditingController();
  //商户简称
  final _referredController = new TextEditingController();
  //商家链接
  final _urlController = new TextEditingController();
  //证件注册号
  final _idNoController = new TextEditingController();
  //证件图片
  List _certificateImg = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this._storeNameController.dispose();
    this._referredController.dispose();
    this._urlController.dispose();
    this._idNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RhColors.colorAppBar,
        brightness: Brightness.dark,
        title: Text('商户信息',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0x0ce25d2b),
                        border: Border(
                            bottom: BorderSide(color: RhColors.colorLine))),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(3)),
                    child: Text(
                      '商户信息用途是为商家注册微信商户号，热乎优选承诺保护商家隐私安全，信息绝不外露，请放心填写!',
                      style: TextStyle(color: RhColors.colorPrimary, fontSize: RhFontSize.fontSize12),
                    ),
                  ),
                  RowWidget(
                      label: '商家名称',
                      expandWidget: TextFieldWidget(
                          controller: this._storeNameController,
                          hintText: '与营业执照的商家名称一致',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '商家简称',
                      expandWidget: TextFieldWidget(
                          controller: this._referredController,
                          hintText: '在支付完成页向买家展示',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '商家链接',
                      expandWidget: TextFieldWidget(
                          controller: this._urlController,
                          hintText: '店铺主页链接',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '证件注册号',
                      expandWidget: TextFieldWidget(
                          controller: this._idNoController,
                          hintText: '与营业执照上的注册号一致',
                          keyboardType: '1'),
                      alignment: 'center'),
                  RowWidget(
                      label: '证件图片',
                      expandWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          this._certificateImg.length == 0
                              ? UploadImg(callBack: (_imgFile) {
                                  this.setState(() {
                                    this._certificateImg.add(_imgFile);
                                  });
                                })
                              : ImageWidget(
                                  imageFileList: this._certificateImg,
                                  callBack: () {
                                    this.setState(() {
                                      this._certificateImg.removeAt(0);
                                    });
                                  }),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(3)),
                            child: Text(
                              '*营业执照图片',
                              style: TextStyle(
                                  color: RhColors.colorPrimary, fontSize: RhFontSize.fontSize12),
                            ),
                          ),
                        ],
                      ),
                      alignment: 'start'),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonWidget(
                          text: '提交',
                          buttonBack: () {
                            ToastTool.toastWidget(context, msg: '请输入商家名称');
                            // if (this._storeNameController.text == '') {
                            // ToastTool.toastWidget(context, msg: '请输入商家名称');
                            // } else if (this._referredController.text == '') {
                            // ToastTool.toastWidget(context, msg: '请输入商家简称');
                            // } else if (this._urlController.text == '') {
                            // ToastTool.toastWidget(context, msg: '请输入商家链接');
                            // } else if (this._idNoController.text == '') {
                            // ToastTool.toastWidget(context, msg: '请输入证件号');
                            // } else if (this._certificateImg.length == 0) {
                            // ToastTool.toastWidget(context, msg: '请上传证件图片');
                            // } else {
                            //   Map req = {
                            //     'merchant_name': this._storeNameController.text,
                            //     'merchant_shortname':
                            //         this._referredController.text,
                            //     'store_url': this._urlController.text,
                            //     'business_license_number':
                            //         this._idNoController.text,
                            //     'business_license_copy': this._certificateImg[0]
                            //   };
                            //   print(req);
                            //   Navigator.pushNamed(context, '/into_identity');
                            // }
                            Navigator.pushNamed(context, '/into_identity');
                          })
                    ],
                  )
                ],
              ))),
    );
  }
}
