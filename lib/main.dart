import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
