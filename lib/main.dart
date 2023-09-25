import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/provider/product_provider.dart';
import 'package:stock_check/provider/user_provider.dart';
import 'package:stock_check/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider<ProductProvider>(
        create: (context) => ProductProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'TradePro',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: green33),
            useMaterial3: true,
          ),
          initialRoute: RouteName.splash_route,
          //initial page of this application
          routes: routes,
        );
      });
    });
  }
}
