// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tn360/widgets/app_icon_new.dart';
import 'package:tn360/widgets/small_text.dart';

import '../../base/custom_loader.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/profile_widget.dart';
import '../cart/cart_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            centerTitle: true,
            title: BigText(
              text: "Profile",
              size: 24,
              color: Colors.white,
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart),
                  label: Text("000"),
                  color: Colors.white,
                ),
              )
            ]),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height10),
                        child: Column(
                          children: [
                            //Profile icon
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/image/avatar.png'),
                                  radius: Dimensions.radius20 * 1.5,
                                ),
                                SizedBox(width: 20.0),
                                BigText(text: userController.userModel.name),
                              ],
                            ),
                            Divider(color: Colors.black),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ProfileWidget(
                                        appIconN: AppIconN(
                                          icon: Icons.email_outlined,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        smallText: SmallText(
                                          text: userController.userModel.email,
                                          color: Colors.black,
                                        )),

                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),

                                    ProfileWidget(
                                        appIconN: AppIconN(
                                          icon: Icons.phone,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        smallText: SmallText(
                                          text: userController.userModel.phone,
                                          color: Colors.black,
                                        )),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    //address
                                    GetBuilder<LocationController>(
                                        builder: (locationController) {
                                      if (_userLoggedIn &&
                                          locationController
                                              .addressList.isEmpty) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(RouteHelper
                                                .getAddAddressPage());
                                          },
                                          child: ProfileWidget(
                                              appIconN: AppIconN(
                                                icon: Icons.location_on,
                                                iconSize:
                                                    Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              smallText: SmallText(
                                                text: "Fill your address",
                                                color: Colors.black,
                                              )),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(RouteHelper
                                                .getAddAddressPage());
                                          },
                                          child: ProfileWidget(
                                              appIconN: AppIconN(
                                                icon: Icons.location_on,
                                                iconSize:
                                                    Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              smallText: SmallText(
                                                text: "Your address",
                                                color: Colors.black,
                                              )),
                                        );
                                      }
                                    }),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Builder(builder: (userController) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: ProfileWidget(
                                            appIconN: AppIconN(
                                              icon: Icons.favorite_border,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            smallText: SmallText(
                                              text: "Favourite Products",
                                              color: Colors.black,
                                            )),
                                      );
                                    }),

                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Builder(builder: (userController) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteHelper.getCartPage());
                                        },
                                        child: ProfileWidget(
                                            appIconN: AppIconN(
                                              icon:
                                                  Icons.shopping_cart_outlined,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            smallText: SmallText(
                                              text: "Previous Orders",
                                              color: Colors.black,
                                            )),
                                      );
                                    }),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Builder(builder: (userController) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: ProfileWidget(
                                            appIconN: AppIconN(
                                              icon: Icons.payment,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            smallText: SmallText(
                                              text: "Payment Options",
                                              color: Colors.black,
                                            )),
                                      );
                                    }),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Builder(builder: (context) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: ProfileWidget(
                                            appIconN: AppIconN(
                                              icon: Icons
                                                  .notifications_none_outlined,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            smallText: SmallText(
                                              text: "Communication Preferences",
                                              color: Colors.black,
                                            )),
                                      );
                                    }),

                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Builder(builder: (context) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: ProfileWidget(
                                            appIconN: AppIconN(
                                              icon: Icons.lock_outline,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            smallText: SmallText(
                                              text: "Login Settings",
                                              color: Colors.black,
                                            )),
                                      );
                                    }),

                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Builder(builder: (context) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: ProfileWidget(
                                            appIconN: AppIconN(
                                              icon: Icons
                                                  .contact_support_outlined,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            smallText: SmallText(
                                              text: "Support",
                                              color: Colors.black,
                                            )),
                                      );
                                    }),

                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //message
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.find<LocationController>()
                                              .clearAddressList();
                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        } else {
                                          print("you logged out");
                                        }
                                      },
                                      child: ProfileWidget(
                                          appIconN: AppIconN(
                                            icon: Icons.login_outlined,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          smallText: SmallText(
                                            text: "Log Out",
                                            color: Colors.black,
                                          )),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 20,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                                //fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signintocontinue.png"))),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSignInPage());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 3,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(
                            child: BigText(
                              text: "Sign in",
                              color: Colors.white,
                              size: Dimensions.font26,
                            ),
                          ),
                        ),
                      )
                    ],
                  )));
          },
        ));
  }
}
