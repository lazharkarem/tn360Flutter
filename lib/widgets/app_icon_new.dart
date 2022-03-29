// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';

class AppIconN extends StatelessWidget {
  final IconData icon;

  final double size;
  final double iconSize;
  AppIconN({Key? key, required this.icon, this.size = 40, this.iconSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Icon(
        icon,
        size: iconSize,
      ),
    );
  }
}
