// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackBar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import 'sign_up_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Email addres");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getIntial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        Container(
                          height: Dimensions.screenHeight * 0.25,
                          child: Center(
                            child: Center(
                                child: Image.asset(
                              "assets/image/logo.png",
                              width: Dimensions.screenWidth * 0.5,
                            )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontSize: Dimensions.font20 * 3 +
                                        Dimensions.font20 / 2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Sign into your account",
                                  style: TextStyle(
                                      fontSize: Dimensions.font20,
                                      //fontWeight: FontWeight.bold),
                                      color: Colors.grey[500]))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                            textController: emailController,
                            hintText: "Email",
                            icon: Icons.email),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                          textController: passwordController,
                          hintText: "Password",
                          icon: Icons.password_sharp,
                          isObscure: true,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                                text: TextSpan(
                                    text: "Sing into your account",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: Dimensions.font20 / 2))),
                            SizedBox(
                              width: Dimensions.width20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.mainColor),
                            child: Center(
                              child: BigText(
                                text: "Sign in",
                                size: Dimensions.font20 + Dimensions.font20 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20 / 2),
                                children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage(),
                                      transition: Transition.fade),
                                text: " Create",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainblackColor,
                                    fontSize: Dimensions.font20 / 2),
                              )
                            ])),
                      ],
                    ),
                  )
                : CustomLoader();
          },
        ));
  }
}
