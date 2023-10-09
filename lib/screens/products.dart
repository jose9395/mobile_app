import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:provider/provider.dart';
import 'package:stock_check/provider/product_provider.dart';
import 'package:stock_check/screens/edit_product_screen.dart';
import 'package:stock_check/screens/pdf_preview.dart';
import 'package:stock_check/widget/delete_dismiss.dart';
import 'package:stock_check/widget/edit_dismiss.dart';
import 'package:stock_check/widget/image_screen.dart';
import 'package:stock_check/widget/small_button.dart';
import 'package:stock_check/widget/snack_bar.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<ProductModel> item = [];
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "pdf",
            elevation: 0,
            backgroundColor: green33,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  CustomPDFViewScreen(item:item)));
            },
            child: Icon(
              Icons.picture_as_pdf,
              color: white,
              size: 30 * SizeConfig.widthMultiplier!,
            ),
          ),
          SizedBox(width: width * 0.02,),
          FloatingActionButton(
            heroTag: "add",
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
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .selectProducts(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<ProductProvider>(
                child: Center(
                  child: Text(
                    'No products added',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.content,
                  ),
                ),
                builder: (context, productProvider, child) => productProvider
                        .item.isEmpty
                    ? child!
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: productProvider.item.length,
                        itemBuilder: (context, index) {
                          item = productProvider.item;
                         return Dismissible(
                            key: ValueKey(productProvider.item[index].id),
                            background: const DeleteDismiss(
                                verticalMargin: 0.03),
                            secondaryBackground: const EditDismiss(
                                verticalMargin: 0.03),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                return showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(width * 0.02),
                                      topRight: Radius.circular(width * 0.02),
                                    ),
                                  ),
                                  backgroundColor: green5e,
                                  context: context,
                                  builder: (context) =>
                                      DeleteProductBottomSheet(
                                        index: index,
                                        productProvider: productProvider,
                                      ),
                                );
                              } else {
                                //edit product
                                var helperVar = productProvider.item[index];
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProductScreen(
                                          id: helperVar.id,
                                          productName: helperVar.productName,
                                          productPrice: helperVar.productPrice,
                                          productImage: helperVar.productImage,
                                          index: index,
                                          code: helperVar.code,
                                          category: helperVar.category,
                                          description: helperVar.description,
                                          size: helperVar.packagesize,
                                          mrp: helperVar.mrp,
                                        ),
                                  ),
                                );
                              }
                            },
                            child: MainBody(
                              productProvider: productProvider,
                              index: index,
                            ),
                          );
                        }
                      ),
              ),
      ),
    );
  }
}

class DeleteProductBottomSheet extends StatelessWidget {
  const DeleteProductBottomSheet({
    Key? key,
    required this.productProvider,
    required this.index,
  }) : super(key: key);
  final ProductProvider productProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var helper = productProvider.item[index];
    return Container(
      width: width,
      height: height * 0.23,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Do you want to delete the ${helper.productName}?',
            maxLines: 2,
            style: AppTextStyle.content,
          ),
          Row(
            children: [
              Expanded(
                child: SmallRedElevationButton(
                  text: 'Delete it',
                  color: green67,
                  onPress: () async {
                    productProvider.deleteProductById(helper.id);
                    productProvider.item.removeAt(index);
                    snackBarSuccessWidget(context, 'Product removed');
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: SmallRedElevationButton(
                  text: 'Return',
                  color: white238,
                  onPress: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.productProvider,
    required this.index,
  }) : super(key: key);
  final ProductProvider productProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var helper = productProvider.item[index];
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.03),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      shadowColor: Colors.white,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    maxLines: 3,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'product name : ',
                          style: AppTextStyle.content,
                        ),
                        TextSpan(
                          text: helper.productName,
                          style: AppTextStyle.content,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "price : ",
                          style: AppTextStyle.content,
                        ),
                        TextSpan(
                          text: helper.productPrice,
                          style: AppTextStyle.content,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Product Code : ",
                          style: AppTextStyle.content,
                        ),
                        TextSpan(
                          text: helper.code,
                          style: AppTextStyle.content,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Product Size : ",
                          style: AppTextStyle.content,
                        ),
                        TextSpan(
                          text: helper.packagesize,
                          style: AppTextStyle.content,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Product Category : ",
                          style: AppTextStyle.content,
                        ),
                        TextSpan(
                          text: helper.category,
                          style: AppTextStyle.content,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Description : ",
                          style: AppTextStyle.content,
                        ),
                        TextSpan(
                          text: helper.description,
                          style: AppTextStyle.content,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                helper.productImage.toString() != '0'
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageScreen(
                                  image: File(helper.productImage),
                                  heroTag: 'flutterLogo$index',
                                ),
                              ),
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageScreen(
                                  image: File(helper.productImage),
                                  heroTag: 'flutterLogo$index',
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'flutterLogo$index',
                            child: FadeInImage(
                              placeholder: const AssetImage('assets/images/loading.gif'),
                              image: FileImage(File(helper.productImage)),
                              width: width * 0.25,
                              height: height * 0.17,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              placeholderFit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Image.asset(
                        'no_image.png',
                        height: width * 0.27,
                        width: width * 0.2,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
