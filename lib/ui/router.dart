import 'package:fabrishop/ui/pages/add_category/category_add.dart';
import 'package:fabrishop/ui/pages/add_product/product_add.dart';
import 'package:fabrishop/ui/pages/home/product_page.dart';
import 'package:fabrishop/ui/pages/login/login_page.dart';
import 'package:fabrishop/ui/pages/intro/register_page.dart';
import 'package:fabrishop/ui/pages/intro/welcome_page.dart';
import 'package:fabrishop/ui/pages/orders/orders_page.dart';
import 'package:fabrishop/ui/pages/settings/settings_page.dart';
import 'package:fabrishop/ui/pages/store/store_page.dart';
import 'package:fabrishop/ui/pages/store_contact/store_contact_page.dart';
import 'package:fabrishop/ui/pages/store_edit/store_edit_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'welcome': (BuildContext context) => WelcomePage(),
    'register': (BuildContext context) => RegisterPage(),
    'login': (BuildContext context) => LoginPage(),
    'product': (BuildContext context) => ProductPage(),
    'product_add': (BuildContext context) => ProductAdd(),
    'category_add': (BuildContext context) => CategoryAdd(),
    'order': (BuildContext context) => OrderPage(),
    'setting': (BuildContext context) => SettingsPage(),
    'store': (BuildContext context) => StorePage(),
    'store_edit': (BuildContext context) => StoreEditPage(),
    'store_contact': (BuildContext context) => StoreContactPage(),
  };
}
