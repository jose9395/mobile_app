import 'package:flutter/material.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/routes/routes.dart';
import 'package:stock_check/screens/products.dart';
import 'package:stock_check/screens/users.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: green33,
            centerTitle: true,
            title: Text("TradePro",style: AppTextStyle.content_white),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.supervised_user_circle), text: "Customers"),
                Tab(icon: Icon(Icons.shopping_cart_outlined), text: "Products")
              ],
            ),
          ),
          body:const TabBarView(
            children: [
              UserList(),
              ProductsList()
            ],
          ) ,
        ),
      ),
    );
  }
}
