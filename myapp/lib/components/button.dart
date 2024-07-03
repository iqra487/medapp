import 'package:flutter/material.dart';
import 'package:myapp/utils/config.dart';

class Button extends StatelessWidget {
  const Button({
    required this.width,
    required this.title,
    required this.disable,
    required this.onPressed,
    super.key,
  });

  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: Config.primaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: disable ? null : onPressed,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
    );
  }
}
