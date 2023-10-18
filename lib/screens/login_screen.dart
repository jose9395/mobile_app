import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:stock_check/const/image_path.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/widget/custom_button.dart';
import 'package:stock_check/widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obSecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24 * SizeConfig.widthMultiplier!),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: 80 * SizeConfig.heightMultiplier!,
                        bottom: 32 * SizeConfig.heightMultiplier!),
                    child: Image.asset(
                      ImagePath.logo,
                      width: 84.21 * SizeConfig.widthMultiplier!,
                      height: 48 * SizeConfig.heightMultiplier!,
                    )),
                Text(
                  "TradePro",
                  style: AppTextStyle.title,
                ),
                SizedBox(
                  height: 48 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                  textEditingController: nameController,
                  onChanged: (value) {},
                  textInputType: TextInputType.text,
                  isObsecure: false,
                  hint: "Enter your email",
                  label: 'Email address',
                ),
                SizedBox(
                  height: 12 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                    textEditingController: passwordController,
                    onChanged: (value) {},
                    textInputType: TextInputType.visiblePassword,
                    isObsecure: obSecurePassword,
                    hint: "Enter your password",
                    onSuffixTap: () {
                      obSecurePassword = !obSecurePassword;
                    },
                    suffixWidget: Icon(
                      obSecurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: grey80,
                      size: 20 * SizeConfig.widthMultiplier!,
                    ),
                    label: 'Password'),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                ),
                CustomButton(
                  text: "Login",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteName.dashboard, (Route<dynamic> route) => false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
