import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/_core/assets.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/buttons.dart';
import 'package:tmdp_getx_mvc/view/auth/common_text_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final utilityController = Get.find<UtitlityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor_5,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                height: 95.h,
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.tmdbLogo,
                      height: 10.h,
                      width: 20.w,
                    ),
                    SizedBox(height: 8.w),
                    CommonTextField(
                      icon: Icons.person,
                      label: "Username",
                      controller: authController.usernameController,
                      focusNode: authController.usernameFocusNode,
                      onFieldSubmit: (input) {
                        if (authController.passwordController.text.isEmpty) {
                          authController.passwordFocusNode.requestFocus();
                        }
                      },
                      validator: authController.validateUsername,
                    ),
                    SizedBox(height: 4.w),
                    CommonTextField(
                      icon: Icons.password,
                      label: "Password",
                      controller: authController.passwordController,
                      focusNode: authController.passwordFocusNode,
                      onFieldSubmit: (input) {
                        if (authController.usernameController.text.isEmpty) {
                          authController.usernameFocusNode.requestFocus();
                        }
                      },
                      validator: authController.validatePassword,
                      obscureText: true,
                    ),
                    SizedBox(height: 8.w),
                    PrimaryButton(
                      size: SIZES.large,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      horizPadding: 0,
                      btnText: "Login",
                    ),
                    const SizedBox(height: 6),
                    PrimaryButton(
                      size: SIZES.large,
                      onPressed: () async {
                        await authController.createGuestSession();
                      },
                      horizPadding: 0,
                      btnText: "Login as Guest",
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: AppTheme.grey1,
                              ),
                        ),
                        GestureDetector(
                          onTap: () {
                            utilityController.loadUrl(
                                uri: "https://www.themoviedb.org/signup");
                          },
                          child: Text(
                            "Click here",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
