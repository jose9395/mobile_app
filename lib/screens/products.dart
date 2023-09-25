import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:provider/provider.dart';
import 'package:stock_check/provider/product_provider.dart';
import 'package:stock_check/screens/list_items/product-list-item.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        Provider.of<ProductProvider>(context, listen: false).getAllProduct();
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.allProduct.isEmpty) {
          return const Center(
            child: Text("No Products Available"),
          );
        } else {
          final product = value.allProduct;
          return ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                return ProductListItem(
                  name: product[index].productName,
                  description: product[index].description,
                  image: product[index].brandImage,
                  price: product[index].price,
                  prodId: product[index].id,
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: green33,
        onPressed: () {
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
