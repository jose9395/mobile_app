import 'package:flutter/material.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/screens/login_screen.dart';
import 'package:stock_check/screens/splash_screen.dart';


final Map<String, WidgetBuilder> routes = {
  RouteName.splash_route : (context) => SplashScreen(),
  RouteName.login_route : (context) => LoginScreen()


};