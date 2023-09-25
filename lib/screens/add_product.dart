import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/widget/custom_appbar.dart';
import 'package:stock_check/widget/custom_button.dart';
import 'package:stock_check/widget/custom_text_field.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> createFormKey = GlobalKey<FormState>();
  final TextEditingController tradeNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController whatsappNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

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
                        textEditingController: tradeNameController,
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
                        textEditingController: nameController,
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
                        textEditingController: whatsappNoController,
                        isObsecure: false,
                        textInputType: TextInputType.number,
                        onChanged: (value) {}),
                    SizedBox(
                      height: 20 * SizeConfig.heightMultiplier!,
                    ),
                    CustomTextField(
                        label: "Description",
                        isrequired: true,
                        hint: "Enter description",
                        validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                        textEditingController: addressController,
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
                        textEditingController: gstController,
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
                        textEditingController: locationController,
                        isObsecure: false,
                        textInputType: TextInputType.name,
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
                        textEditingController: locationController,
                        isObsecure: false,
                        textInputType: TextInputType.name,
                        onChanged: (value) {}),
                    SizedBox(
                      height: 30 * SizeConfig.heightMultiplier!,
                    ),
                    CustomButton(
                      text: "Add Product",
                      onPressed: () {

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

}
