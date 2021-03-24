import 'package:flutter/material.dart';

class ListBottom extends StatelessWidget {
  String _toast = "";
  ListBottom(this._toast);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          '${this._toast}',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF333333),
          ),
        ),
      );
  }
}