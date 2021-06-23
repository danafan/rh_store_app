import 'package:flutter/material.dart';

class AuditStatus extends StatefulWidget {
  @override
  _AuditStatusState createState() => _AuditStatusState();
}

class _AuditStatusState extends State<AuditStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0a0b17),
        brightness: Brightness.dark,
        title:
            Text('', style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.phone_android_outlined),
              Text('正在审核中...')
            ]),
      ),
    );
  }
}
