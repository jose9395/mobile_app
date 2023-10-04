import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_check/config/size_config.dart';
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
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _mrpController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _codeController.dispose();
    _categoryController.dispose();
    _sizeController.dispose();
    _mrpController.dispose();
    _descriptionController.dispose();
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
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: green33,
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
          padding: EdgeInsets.symmetric(horizontal:10 * SizeConfig.widthMultiplier!),
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
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                //product name
                CustomTextField(
                    label: "Product Name",
                    isrequired: true,
                    hint: "Enter Product Name",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _nameController,
                    isObsecure: false,
                    textInputType: TextInputType.name,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                //product price
                CustomTextField(
                    label: "Product price",
                    isrequired: true,
                    hint: "Enter Product Price",
                    length: 4,
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _priceController,
                    isObsecure: false,
                    textInputType: TextInputType.number,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Product Code",
                    isrequired: true,
                    hint: "Enter Product Code",
                    length: 8,
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _codeController,
                    isObsecure: false,
                    textInputType: TextInputType.text,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Product Category",
                    isrequired: true,
                    hint: "Enter Product Category",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _categoryController,
                    isObsecure: false,
                    textInputType: TextInputType.text,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Product MRP",
                    isrequired: true,
                    hint: "Enter Product MRP",
                    length: 5,
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _mrpController,
                    isObsecure: false,
                    textInputType: TextInputType.number,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Product Size",
                    isrequired: true,
                    hint: "Enter Product Size",
                    length: 8,
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _sizeController,
                    isObsecure: false,
                    textInputType: TextInputType.number,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Product Description",
                    isrequired: true,
                    hint: "Enter Product Description",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _descriptionController,
                    isObsecure: false,
                    textInputType: TextInputType.text,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                CustomButton(
                  text: "Add Product",
                  onPressed: () async{
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!_key.currentState!.validate()) {
                      snackBarErrorWidget(context,"All field is mandatory");
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
                            _codeController.text,
                            _categoryController.text,
                            _mrpController.text,
                            _descriptionController.text,
                            _sizeController.text
                          );
                          _priceController.clear();
                          _nameController.clear();
                          _codeController.clear();
                          _categoryController.clear();
                          _mrpController.clear();
                          _descriptionController.clear();
                          _sizeController.clear();
                          productProvider.deleteImage();
                          Navigator.of(context).pop();
                          snackBarSuccessWidget(context, 'Product added');
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
