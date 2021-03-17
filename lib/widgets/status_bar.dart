import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  Color _backGroundColor;
  StatusBar(this._backGroundColor);
  @override
  Widget build(BuildContext context) {
    print('wqe');
    return Container(
      color: _backGroundColor,
      height: MediaQuery.of(context).padding.top,
    );
  }
}
