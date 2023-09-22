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
            title: "Add Users",
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
                    CustomTextField(
                        label: "Mobile No",
                        isrequired: true,
                        hint: "Mobile No",
                        validation: (value) =>
                        value!.isEmpty ? "This field is required" : null,
                        textEditingController: mobileNoController,
                        isObsecure: false,
                        textInputType: TextInputType.number,
                        onChanged: (value) {}),
                    SizedBox(
                      height: 20 * SizeConfig.heightMultiplier!,
                    ),
                    CustomTextField(
                        label: "Whats App No",
                        isrequired: true,
                        hint: "Whats App No",
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
                        label: "Address",
                        isrequired: true,
                        hint: "Address",
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
                        label: "GST No",
                        isrequired: true,
                        hint: "GST No",
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
                        label: "Location",
                        isrequired: true,
                        hint: "Location",
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
                      text: "Add User",
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
