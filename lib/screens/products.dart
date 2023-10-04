import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:provider/provider.dart';
import 'package:stock_check/provider/product_provider.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        itemBuilder: (context, index) => Dismissible(
                          key: ValueKey(productProvider.item[index].id),
                          child: MainBody(
                            productProvider: productProvider,
                            index: index,
                          ),
                          background: const DeleteDismiss(verticalMargin: 0.03),
                          secondaryBackground:
                              const EditDismiss(verticalMargin: 0.03),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              //delete
                              return showModalBottomSheet(
                                shape: bottomSheetborderWidget(context),
                                backgroundColor: backGroundColor,
                                context: context,
                                builder: (context) => DeleteProductBottomSheet(
                                  index: index,
                                  productProvider: productProvider,
                                ),
                              );
                            } else {
                              //edit product
                              var helperVar = productProvider.item[index];
                              navigatorPushWidget(
                                context,
                                EditProductScreen(
                                  id: helperVar.id,
                                  productName: helperVar.productName,
                                  productPrice: helperVar.productPrice,
                                  productImage: helperVar.productImage,
                                  index: index,
                                ),
                              );
                            }
                          },
                        ),
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
            style: Responsive.isMobile(context)
                ? bodyBoldBlackMobileStyle
                : bodyBoldBlackTabletStyle,
          ),
          Row(
            children: [
              Expanded(
                child: SmallRedElevationButton(
                  text: 'Delete it',
                  onPress: () async {
                    productProvider.deleteProductById(helper.id);
                    productProvider.item.removeAt(index);
                    snackBarSuccessWidget(context, 'Product removed');
                    navigatorPopWidget(context);
                  },
                ),
              ),
              Expanded(
                child: SmallWhiteElevationButton(
                  text: 'Return',
                  onPress: () {
                    navigatorPopWidget(context);
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
      shape: shapeWidget(context),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      shadowColor: shadowColor,
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
                  getBodyBoldText(
                    context,
                    'product name: ',
                    helper.productName,
                  ),
                  SizedBox(height: height * 0.02),
                  getPriceText(context, 'Price: ', helper.productPrice),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                helper.productImage.toString() != '0'
                    ? ClipRRect(
                        borderRadius: borderWidget(context),
                        child: GestureDetector(
                          onTap: () {
                            navigatorPushWidget(
                              context,
                              ImageScreen(
                                image: File(helper.productImage),
                                heroTag: 'flutterLogo$index',
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'flutterLogo$index',
                            child: FadeInImage(
                              placeholder: const AssetImage('loading.gif'),
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
