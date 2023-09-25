import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/localdb/user_table.dart';
import 'package:stock_check/model/user_model.dart';
import 'package:stock_check/widget/custom_appbar.dart';
import 'package:stock_check/widget/custom_button.dart';
import 'package:stock_check/widget/custom_text_field.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
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
                    label: "Trade name",
                    isrequired: true,
                    hint: "Enter Trade name",
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
                    label: "Name",
                    isrequired: true,
                    hint: "Enter Name",
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
                    hint: "Enter Mobile No",
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
                    hint: "Enter Whats App No",
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
                    hint: "Enter Address",
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
                    hint: "Enter GST No",
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
                    hint: "Enter Location",
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
                    _addItem(User(
                        name: nameController.value.text,
                        tradeName: tradeNameController.value.text,
                        mobileNo: mobileNoController.value.text,
                        whatsAppNo: whatsappNoController.value.text,
                        address: addressController.value.text,
                        gstNumber: gstController.value.text,
                        location: locationController.value.text));
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

  Future<void> _addItem(User user) async {
    await SqliteDatabaseHelper().insertUser(user);
  }
}
