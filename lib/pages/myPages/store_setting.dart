import 'package:flutter/material.dart';

class StoreSetting extends StatefulWidget {
  @override
  _StoreSettingState createState() => _StoreSettingState();
}

class _StoreSettingState extends State<StoreSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('店铺设置')
      )
    );
  }
}