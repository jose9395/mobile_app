import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/screens/list_items/user-list-item.dart';


class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: green33,
        onPressed: (){
          Navigator.of(context).pushNamed(RouteName.addproduct);
        },
        child: Icon(
          Icons.add,
          color: white,
          size: 30 * SizeConfig.widthMultiplier!,
        ),
      ),
    );
  }
}
