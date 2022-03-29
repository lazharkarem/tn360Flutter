// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tn360/widgets/app_icon_new.dart';
import 'package:tn360/widgets/small_text.dart';

import '../utils/dimensions.dart';
import 'app_icon.dart';
import 'big_text.dart';

class ProfileWidget extends StatelessWidget {
  AppIconN appIconN;
  SmallText smallText;
  ProfileWidget({Key? key, required this.appIconN, required this.smallText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          appIconN,
          SizedBox(
            width: Dimensions.height10,
          ),
          Expanded(child: smallText),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2))
      ]),
    );
  }
}
