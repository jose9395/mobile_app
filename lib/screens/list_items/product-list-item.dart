import 'package:flutter/material.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/screens/add_product.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.prodId});

  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final String? prodId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 3,
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(image.toString()),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Name : $name",
                  style: AppTextStyle.content,
                ),
                Text(
                  "Price : $price",
                  style: AppTextStyle.content,
                ),
                Text(
                  "Description  : $description",
                  style: AppTextStyle.content,
                )
              ],
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.delete,
                    color: red33,
                  )),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.addproduct,
                        arguments: AddProduct(prodId: prodId ?? ""));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: red33,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
