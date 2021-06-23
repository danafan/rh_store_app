import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../widgets/dialog_widget.dart';

/// 扫码页面
class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final picker = ImagePicker();

  StateSetter stateSetter;

  IconData lightIcon = Icons.flash_on;

  ScanController controller = ScanController();

  List<String> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0a0b17),
          brightness: Brightness.dark,
          title: Text('扫码核销',
              style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Stack(children: [
      ScanView(
        controller: controller,
        scanAreaScale: 0.7,
        scanLineColor: Color(0xffe25d2b),
        onCapture: (String data) async {
          await showResult(data);
          controller.resume();
        },
      ),
      Positioned(
        left: 50,
        bottom: 100,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            stateSetter = setState;
            return MaterialButton(
                child: Icon(lightIcon, size: 30, color: Color(0xffffffff)),
                onPressed: () {
                  controller.toggleTorchMode();
                  if (lightIcon == Icons.flash_on) {
                    lightIcon = Icons.flash_off;
                  } else {
                    lightIcon = Icons.flash_on;
                  }
                  stateSetter(() {});
                });
          },
        ),
      ),
      Positioned(
        right: 50,
        bottom: 100,
        child: MaterialButton(
            child: Icon(Icons.image, size: 30, color: Color(0xffffffff)),
            onPressed: () async {
              await pickImage();
            }),
      ),
    ]);
  }

  //显示结果
  showResult(data) {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: DialogWidget(
              title: '订单详情',
              content_widget: Container(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //套餐主图
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text('商品主图：',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 14)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                            'https://img.ivsky.com/img/tupian/t/202002/28/riben_meishi-001.jpg',
                            height: 60,
                            width: 78,
                            fit: BoxFit.cover),
                      )
                    ]),
                    Text('商品名称：胡晓川双人套餐',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            height: ScreenUtil().setHeight(2.8))),
                    Text('商品单价：¥98.00',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            height: ScreenUtil().setHeight(2.8))),
                    Text('购买数量：x1',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            height: ScreenUtil().setHeight(2.8))),
                    Text('平台红包：-¥10.00',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            height: ScreenUtil().setHeight(2.8))),
                    Text('积分抵扣：-¥10.00',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            height: ScreenUtil().setHeight(2.8))),
                    Text('余额抵扣：-¥0.00',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            height: ScreenUtil().setHeight(2.8))),
                    Text('实付金额：¥88.00',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            height: ScreenUtil().setHeight(2.8))),
                    Text('付款时间：2020-08-20 13:32:48',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            height: ScreenUtil().setHeight(2.8)))
                  ],
                )),
              ),
              cancel_fun: () {},
              confirm_fun: () {
                print('确认解除');
              },
              confim_text:'立即核销'
              ),
        );
      },
    ).then((val) {});
  }

  //获取相册图片
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String value = await Scan.parse(pickedFile.path);
      showResult(value);
    } else {
      print('没有选择图片');
    }
  }
}
