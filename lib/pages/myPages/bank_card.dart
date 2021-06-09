import 'package:flutter/material.dart';

class BankCard extends StatefulWidget {
  @override
  _BankCardState createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff0a0b17),
            title: Text(
              '银行卡管理',
              style: TextStyle(color: Color(0xffffffff), fontSize: 18),
            )),
        body: Container(
          alignment: Alignment.center,
          child: Text('添加银行卡'),
        )
    );
  }
}