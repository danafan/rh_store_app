import 'package:flutter/material.dart';

class PackageManagement extends StatefulWidget {
  @override
  _PackageManagementState createState() => _PackageManagementState();
}

class _PackageManagementState extends State<PackageManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('套餐管理')
      )
    );
  }
}