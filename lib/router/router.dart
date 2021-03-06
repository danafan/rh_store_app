import 'package:flutter/material.dart';

import '../pages/navigator_bar.dart';
import '../widgets/photo_view.dart';
import '../pages/commentPages/complaint.dart';
import '../pages/myPages/bill_page.dart';
import '../pages/myPages/cash_page.dart';
import '../pages/myPages/store_setting.dart';
import '../pages/map_page.dart';
import '../pages/myPages/storeStting/business_hours.dart';
import '../pages/myPages/storeStting/business_info.dart';
import '../pages/myPages/package_page.dart';
import '../pages/myPages/packagePages/created_package.dart';
import '../pages/myPages/category_page.dart';
import '../pages/myPages/menu_page.dart';
import '../pages/myPages/menuPages/add_menu.dart';
import '../pages/myPages/categoryPages/choose_menu.dart';
import '../pages/myPages/categoryPages/category_management.dart';
import '../pages/myPages/bank_card.dart';
import '../pages/myPages/bankCard/edit_bank.dart';
import '../pages/login_regis.dart';
import '../pages/login.dart';
import '../pages/into_certificate.dart';
import '../pages/into_identity.dart';
import '../pages/into_admin.dart';
import '../pages/audit_status.dart';
import '../pages/homePages/qr_code_scanner.dart';
import '../pages/homePages/message_page.dart';

//配置路由
final routes = {
  '/navigator': (context) => NavigatorBar(),
  '/photo_view': (context, {arguments}) => PhotoView(arguments: arguments),
  '/complaint': (context, {arguments}) => Complaint(arguments: arguments),
  '/bill_page': (context) => BillPage(),
  '/cash_page': (context) => CashPage(),
  '/store_setting': (context) => StoreSetting(),
  '/map_page': (context) => MapPage(),
  '/business_hours': (context) => BusinessHours(),
  '/business_info': (context) => BusinessInfo(),
  '/package_management': (context) => PackagePage(),
  '/created_package': (context, {arguments}) =>
      CreatedPackage(arguments: arguments),
  '/category_page': (context) => CategoryPage(),
  '/menu_page': (context) => MenuPage(),
  '/add_menu': (context, {arguments}) => AddMenu(arguments: arguments),
  '/choose_menu': (context, {arguments}) => ChooseMenu(arguments: arguments),
  '/category_management': (context) => CategoryManagement(),
  '/bank_card': (context) => BankCard(),
  '/edit_bank': (context) => EditBank(),
  '/login_regis': (context) => LoginRegis(),
  '/login': (context, {arguments}) => Login(arguments: arguments),
  '/into_certificate': (context) => IntoCertificate(),
  '/into_identity': (context) => IntoIdentity(),
  '/into_admin': (context) => IntoAdmin(),
  '/audit_status': (context) => AuditStatus(),
  '/qr_code_scanner': (context) => QRScannerPage(),
  '/message_page': (context) => MessagePage(),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
