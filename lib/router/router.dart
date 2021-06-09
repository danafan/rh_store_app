import 'package:flutter/material.dart';

import '../pages/navigator_bar.dart';
import '../widgets/photo_view.dart';
import '../pages/commentPages/complaint.dart';
import '../pages/myPages/bill_page.dart';
import '../pages/myPages/cash_page.dart';
import '../pages/myPages/store_setting.dart';
import '../pages/myPages/business_hours.dart';
import '../pages/myPages/business_info.dart';
import '../pages/myPages/package_management.dart';
import '../pages/myPages/created_package.dart';
import '../pages/myPages/category_page.dart';
import '../pages/myPages/menu_page.dart';
import '../pages/myPages/add_menu.dart';
import '../pages/myPages/choose_menu.dart';
import '../pages/myPages/category_management.dart';
import '../pages/myPages/bank_card.dart';


//配置路由
final routes = {
  '/': (context) => NavigatorBar(),
  '/photo_view': (context,{arguments}) => PhotoView(arguments:arguments),
  '/complaint': (context,{arguments}) => Complaint(arguments:arguments),
  '/bill_page': (context) => BillPage(),
  '/cash_page': (context) => CashPage(),
  '/store_setting': (context) => StoreSetting(),
  '/business_hours': (context) => BusinessHours(),
  '/business_info': (context) => BusinessInfo(),
  '/package_management': (context) => PackageManagement(),
  '/created_package': (context,{arguments}) => CreatedPackage(arguments:arguments),
  '/category_page': (context) => CategoryPage(),
  '/menu_page': (context) => MenuPage(),
  '/add_menu': (context,{arguments}) => AddMenu(arguments:arguments),
  '/choose_menu': (context,{arguments}) => ChooseMenu(arguments:arguments),
  '/category_management': (context) => CategoryManagement(),
  '/bank_card': (context) => BankCard(),
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
