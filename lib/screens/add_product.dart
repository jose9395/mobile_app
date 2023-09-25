import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/localdb/product_table.dart';
import 'package:stock_check/model/product_model.dart';
import 'package:stock_check/provider/product_provider.dart';
import 'package:stock_check/utils/image_picker.dart';
import 'package:stock_check/widget/custom_appbar.dart';
import 'package:stock_check/widget/custom_button.dart';
import 'package:stock_check/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key,this.prodId = ""});
  final String prodId;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> createFormKey = GlobalKey<FormState>();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController prodNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String prodImage = "";

  @override
  void initState() {
   if(widget.prodId.isNotEmpty){
 /*    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       Provider.of<ProductProvider>(context, listen: false).getProduct(widget.prodId);
       Provider.of<ProductProvider>(context, listen: false).product?.then((value) {
         priceController.text = value.price.toString();
       });
     });*/
   }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: MyCustomAppbar(
        title: "Add Products",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 20 * SizeConfig.heightMultiplier!,
              horizontal: 24 * SizeConfig.widthMultiplier!),
          child: Form(
            key: createFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                    label: "Category",
                    isrequired: true,
                    hint: "Enter Category",
                    validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                    textEditingController: categoryController,
                    isObsecure: false,
                    textInputType: TextInputType.name,
                    onChanged: (value) {}),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Code",
                    isrequired: true,
                    hint: "Enter code",
                    validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                    textEditingController: codeController,
                    isObsecure: false,
                    textInputType: TextInputType.name,
                    onChanged: (value) {}),

                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                //
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Product name",
                    isrequired: true,
                    hint: "Enter product name",
                    validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                    textEditingController: prodNameController,
                    isObsecure: false,
                    textInputType: TextInputType.number,
                    onChanged: (value) {}),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                ImagePickerWidget(
                  onClear: () {
                    prodImage = "";
                  },
                  title: "Upload Product image",
                  currentImage: prodImage,
                  onSelectedImage: (String imagePath) async {
                    prodImage = imagePath;
                  },
                ),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Description",
                    isrequired: true,
                    hint: "Enter description",
                    validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                    textEditingController: descriptionController,
                    isObsecure: false,
                    textInputType: TextInputType.name,
                    onChanged: (value) {}),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Package size",
                    isrequired: true,
                    hint: "Enter package size",
                    validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                    textEditingController: sizeController,
                    isObsecure: false,
                    textInputType: TextInputType.name,
                    onChanged: (value) {}),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "MRP",
                    isrequired: true,
                    hint: "Enter MRP",
                    validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                    textEditingController: mrpController,
                    isObsecure: false,
                    textInputType: TextInputType.number,
                    onChanged: (value) {}),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    label: "Price",
                    isrequired: true,
                    hint: "Enter price",
                    validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                    textEditingController: priceController,
                    isObsecure: false,
                    textInputType: TextInputType.number,
                    onChanged: (value) {}),
                SizedBox(
                  height: 30 * SizeConfig.heightMultiplier!,
                ),
                CustomButton(
                  text: "Add Product",
                  onPressed: () {
                    addProduct(Product(
                        category: categoryController.value.text,
                        code: codeController.value.text,
                        brandImage: prodImage,
                        productName: prodNameController.value.text,
                        description: descriptionController.value.text,
                        packageSize: sizeController.value.text,
                        mrp: mrpController.value.text,
                        price: priceController.value.text));
                  },
                ),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> addProduct(Product product) async {
    await ProductTable().insertProduct(product);
    Navigator.of(context).pushNamed(RouteName.dashboard);
  }

  Future<void> editProduct() async {

  }

}
