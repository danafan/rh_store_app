import 'package:flutter/material.dart';

import '../service/config_tool.dart';

class AuditStatus extends StatefulWidget {
  @override
  _AuditStatusState createState() => _AuditStatusState();
}

class _AuditStatusState extends State<AuditStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RhColors.colorAppBar,
        brightness: Brightness.dark,
        title:
            Text('', style: TextStyle(color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18)),
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
