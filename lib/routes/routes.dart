import 'dart:js';

import 'package:flutter/material.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/screens/add_users.dart';
import 'package:stock_check/screens/dashboard.dart';
import 'package:stock_check/screens/login_screen.dart';
import 'package:stock_check/screens/splash_screen.dart';


final Map<String, WidgetBuilder> routes = {
  RouteName.splash_route : (context) => const SplashScreen(),
  RouteName.login_route : (context) => const LoginScreen(),
  RouteName.dashboard : (context) => const Dashboard(),
  RouteName.adduser : (context) => const AddUsers(),
};