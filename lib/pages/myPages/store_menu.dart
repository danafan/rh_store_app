import 'package:flutter/material.dart';

class StoreMenu extends StatefulWidget {
  @override
  _StoreMenuState createState() => _StoreMenuState();
}

class _StoreMenuState extends State<StoreMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('店铺菜单')
      )
    );
  }
}