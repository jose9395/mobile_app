import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:stock_check/provider/product_provider.dart';
import 'package:stock_check/widget/container_widget.dart';
import 'package:stock_check/widget/custom_button.dart';
import 'package:stock_check/widget/custom_text_field.dart';
import 'package:stock_check/widget/snack_bar.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key,this.prodId = ""});
  final String prodId;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);

    productProvider.deleteImage();
    return navigatorPopWidget(context);
  }

  navigatorPopWidget(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);
    //
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Add product',
            style: AppTextStyle.sub_title_white,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              productProvider.deleteImage();
              navigatorPopWidget(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return value.showImage == null
                          ? ContainerWidget(
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pick Image',
                              style: AppTextStyle.content,
                            ),
                            Padding(
                              padding: EdgeInsets.all(width * 0.02),
                              child: Icon(
                                Icons.image,
                                size: width * 0.07,
                              ),
                            ),
                          ],
                        ),
                        callback: () {
                          productProvider.pickImage();
                        },
                      )
                          : ContainerWidget(
                        widget: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(width * 0.03),
                              child: FadeInImage(
                                placeholder:
                                const AssetImage('loading.gif'),
                                image: FileImage(value.showImage!),
                                width: width,
                                height: height,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                placeholderFit: BoxFit.contain,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: red33,
                              ),
                              onPressed: () {
                                value.deleteImage();
                              },
                            ),
                          ],
                        ),
                        callback: () {
                          value.pickImage();
                        },
                      );
                    },
                  ),

                //product name
                CustomTextField(
                    label: "Product Name",
                    isrequired: true,
                    hint: "Product Name",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _priceController,
                    isObsecure: false,
                    textInputType: TextInputType.name,
                    onChanged: (value) {}),
                //product price
                CustomTextField(
                    label: "Product price",
                    isrequired: true,
                    hint: "Product price",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _priceController,
                    isObsecure: false,
                    textInputType: TextInputType.number,
                    onChanged: (value) {}),
                CustomButton(
                  text: "Add Product",
                  onPressed: () async{
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!_key.currentState!.validate()) {

                    } else {
                      if (productProvider.fileSize != null &&
                          double.parse(productProvider.fileSize.toString()) >=
                              double.parse('10.00')) {

                      } else {
                        if (productProvider.image != null &&
                            productProvider.fileType != 'png' &&
                            productProvider.fileType != 'jpg' &&
                            productProvider.fileType != 'jpeg') {

                        } else {
                          await productProvider.insertDatabase(
                            _nameController.text,
                            _priceController.text.replaceAll(',', ''),
                            productProvider.showImage == null
                                ? '0'
                                : productProvider.showImage!.path,
                          );
                          _priceController.clear();
                          _nameController.clear();
                          productProvider.deleteImage();
                          snackBarSuccessWidget(context, 'Product added');
                          navigatorPopWidget(context);
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
