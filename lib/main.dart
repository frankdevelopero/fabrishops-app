import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/constants/shared_constants.dart';
import 'package:fabrishop/ui/constants/shared_utils.dart';
import 'package:fabrishop/ui/router.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fabrishop',
      theme: ThemeData(
        primaryColor: primary,
        accentColor: accent,
        hintColor: textColorSecondary,
        primaryColorDark: primaryDark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: getRouteInitial(),
      routes: getApplicationRoutes(),
    );
  }

  String getRouteInitial() {
    String page = "welcome";
    if (PreferenceUtils.getInt(SharedConstants.userId, 0) != 0) {
      page = "product";
    }
    return page;
  }
}
