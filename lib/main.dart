import 'dart:io';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission/permission.dart';

import './router/router.dart';


Future<void> main() async {
  List<PermissionName> permissionNames = [];
    permissionNames.add(PermissionName.Location);
    permissionNames.add(PermissionName.Camera);
    permissionNames.add(PermissionName.Storage);
    // List<Permissions> permissions = await Permission.requestPermissions(permissionNames);
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Color(0xff0a0b17),
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login_regis',
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(primaryColor: Color(0xffe25d2b)),
      ),
    );
  }
}

