import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

import '../widgets/dialog_widget.dart';
import '../widgets/order_detail.dart';
import '../service/toast_tool.dart';

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
  showResult(value) {
    Map dataMap = {'name':'value'};
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: DialogWidget(
              title: '订单详情',
              content_widget: OrderDetail(data:dataMap),
              cancel_fun: () {},
              confirm_fun: () {
                ToastTool.toastWidget(context, msg: '订单已核销!');
                Navigator.of(context).pop();
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
