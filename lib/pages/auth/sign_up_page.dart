// ignore_for_file: prefer_const_constructors

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

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = ["t.png", "f.png", "g.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone", title: "Phone");
      } else if (email.isEmpty) {
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
        showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success registration");
            Get.offNamed(RouteHelper.getIntial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
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
                          child: Image.asset(
                            "assets/image/logo.png",
                            width: Dimensions.screenWidth * 0.5,
                          ),
                        ),
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
                      AppTextField(
                          textController: nameController,
                          hintText: "Name",
                          icon: Icons.person),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                          textController: phoneController,
                          hintText: "Phone",
                          icon: Icons.phone),
                      SizedBox(
                        height: Dimensions.height20 + Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
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
                              text: "Sign up",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Have an account already?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20 / 2))),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text:
                                  "Sign up using one of the following methods",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20 / 2))),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundImage: AssetImage(
                                        "assets/image/" + signUpImage[index]),
                                  ),
                                )),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
