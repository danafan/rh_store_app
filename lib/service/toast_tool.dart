import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastTool {
  static void toastWidget<T>(
    BuildContext context, {
    @required String msg
  }) {
    openToast(context, msg: msg);
  }

  static void openToast(BuildContext context, {@required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
