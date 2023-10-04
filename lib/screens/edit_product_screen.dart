import 'dart:io';
import 'package:animate_do/animate_do.dart';
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


class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    Key? key,
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.index,
    required this.code,
    required this.category,
    required this.description,
    required this.mrp,
    required this.size
  }) : super(key: key);
  final String id;
  final String productName;
  final String productPrice;
  final String productImage;
  final String description;
  final String mrp;
  final String code;
  final String size;
  final String category;
  final int index;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _mrpController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.productName;
    _priceController.text = widget.productPrice;
    _codeController.text = widget.code;
    _categoryController.text = widget.category;
    _sizeController.text = widget.size;
    _mrpController.text = widget.mrp;
    _descriptionController.text = widget.description;
    super.initState();
  }

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
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);
    //
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: green33,
        title: Text(
          'Edit Product',
          style: AppTextStyle.sub_title_white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            navigatorPopWidget(context);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal:10 * SizeConfig.widthMultiplier!),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                FadeInLeft(
                  child: Consumer<ProductProvider>(
                    builder: (context, productP, child) => ContainerWidget(
                      widget: widget.productImage == '0' &&
                          productP.image == null
                          ? FadeInImage(
                        placeholder: const AssetImage('loading.gif'),
                        image: const AssetImage('no_image.png'),
                        height: width * 0.27,
                        width: width * 0.25,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        placeholderFit: BoxFit.contain,
                      ):

                      productP.image != null &&
                          widget.productImage == '0'
                          ? Stack(
                        children: [
                          FadeInImage(
                            placeholder:
                            const AssetImage('loading.gif'),
                            image: FileImage(productP.showImage!),
                            width: width,
                            height: height,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            placeholderFit: BoxFit.contain,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: red54,
                            ),
                            onPressed: () {
                              productP.deleteImage();
                            },
                          ),
                        ],
                      )
                          : productP.image == null
                          ? FadeInImage(
                        placeholder:
                        const AssetImage('loading.gif'),
                        image: FileImage(File(widget.productImage)),
                        height: width,
                        width: width,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        placeholderFit: BoxFit.contain,
                      )
                          : Stack(
                        children: [
                          FadeInImage(
                            placeholder:
                            const AssetImage('loading.gif'),
                            image: FileImage(productP.showImage!),
                            width: width,
                            height: height,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            placeholderFit: BoxFit.contain,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: red54,
                            ),
                            onPressed: () {
                              productP.deleteImage();
                            },
                          ),
                        ],
                      ),
                      callback: () {
                        productP.pickImage();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                //name
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
                CustomTextField(
                    label: "Product Price",
                    isrequired: true,
                    hint: "Enter Product Price",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _priceController,
                    isObsecure: false,
                    length: 4,
                    textInputType: TextInputType.number,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Product Code",
                    isrequired: true,
                    hint: "Enter Product Code",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _codeController,
                    isObsecure: false,
                    length: 8,
                    textInputType: TextInputType.number,
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
                    label: "Product Size",
                    isrequired: true,
                    hint: "Enter Product Size",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _sizeController,
                    isObsecure: false,
                    length: 8,
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
                CustomTextField(
                    label: "Product MRP",
                    isrequired: true,
                    hint: "Enter Product MRP",
                    validation: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                    textEditingController: _mrpController,
                    isObsecure: false,
                    textInputType: TextInputType.number,
                    length: 4,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                CustomButton(
                  text: "Edit Product",
                  onPressed: () async{
                    FocusScope.of(context).requestFocus(FocusNode());
                    var helperVar = productProvider.item[widget.index];
                    var item = productProvider.item
                        .firstWhere((element) => element.id == helperVar.id);

                    if (!_key.currentState!.validate()) {
                      snackBarErrorWidget(context,"Input values are invalid");
                    } else {
                      _key.currentState!.save();
                      if (productProvider.image != null) {
                        if (productProvider.fileType != 'png' &&
                            productProvider.fileType != 'jpg' &&
                            productProvider.fileType != 'jpeg') {
                          snackBarErrorWidget(context,"The selected file format is incorrect");
                        } else {
                          if (double.parse(productProvider.fileSize.toString()) >=
                              double.parse('10.00')) {
                            snackBarErrorWidget(context,"The selected image size is large");
                          } else {
                            productProvider.updateProductNameById(
                              helperVar.id,
                              _nameController.text,
                            );
                            item.productName = _nameController.text;

                            productProvider.updatePriceById(
                              helperVar.id,
                              _priceController.text.replaceAll(',', ''),
                            );
                            item.productPrice =
                                _priceController.text.replaceAll(',', '');

                            if (productProvider.showImage == null &&
                                widget.productImage == '0') {
                              productProvider.updateProductImageById(
                                helperVar.id,
                                '0',
                              );
                              item.productImage = '0';
                            } else {
                              productProvider.updateProductImageById(
                                helperVar.id,
                                productProvider.showImage!.path,
                              );
                              item.productImage = productProvider.showImage!.path;
                            }

                            snackBarSuccessWidget(context, 'Editing done');
                            _priceController.clear();
                            _nameController.clear();
                            //
                            productProvider.deleteImage();
                            navigatorPopWidget(context);
                          }
                        }
                      }
                      else {
                        productProvider.updateProductNameById(
                          helperVar.id,
                          _nameController.text,
                        );
                        item.productName = _nameController.text;

                        productProvider.updatePriceById(
                          helperVar.id,
                          _priceController.text.replaceAll(',', ''),
                        );
                        item.productPrice =
                            _priceController.text.replaceAll(',', '');
                        //

                        snackBarSuccessWidget(context, 'Editing done');
                        _priceController.clear();
                        _nameController.clear();
                        //
                        productProvider.deleteImage();
                        navigatorPopWidget(context);
                      }
                    }
                  },
                ),
                SizedBox(height: height * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
