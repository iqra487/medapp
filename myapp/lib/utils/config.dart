import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenHeight = mediaQueryData!.size.height;
    screenWidth = mediaQueryData!.size.width;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heightSize {
    return screenHeight;
  }

  static const spaceSmall = SizedBox(
    height: 25,
  );
  static final spaceMedium = SizedBox(
    height: screenHeight! * 0.05,
  );
  static final spaceBig = SizedBox(
    height: screenHeight! * 0.08,
  );

  static const outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color.fromARGB(255, 53, 87, 139)));

  static const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.red));

  // static const primaryColor = Color.fromARGB(255, 39, 179, 239);
  static const primaryColor = Color.fromRGBO(28, 38, 62, 1);
  // static const primaryColor = Color.fromRGBO(168, 169, 211, 0.8);

  static const blueGradientColor = RadialGradient(
    colors: [
      Color.fromARGB(255, 79, 115, 187),
      Color.fromARGB(255, 53, 87, 139),
    ],
    radius: 1,
    focal: Alignment(0.5, -0.5),
    tileMode: TileMode.clamp,
  );

  static const greyGradientColor = RadialGradient(
    colors: [
      Color.fromARGB(255, 79, 115, 187),
      Color.fromARGB(255, 71, 72, 74),
    ],
    radius: 1,
    focal: Alignment(0.5, -0.5),
    tileMode: TileMode.clamp,
  );
}
