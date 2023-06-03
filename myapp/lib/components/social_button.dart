import 'package:flutter/material.dart';
import 'package:myapp/utils/config.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({required this.social, super.key});
  final String social;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // style: OutlinedButton.styleFrom(
      //     padding: EdgeInsets.symmetric(vertical: 15),
      //     side: BorderSide(width: 1)),
      onPressed: () {},
      child: SizedBox(
        // width: Config.widthSize * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/$social.png'),
            Text(
              "$social".toUpperCase(),
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
