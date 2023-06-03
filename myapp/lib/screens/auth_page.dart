import 'package:flutter/material.dart';
import 'package:myapp/components/login_form.dart';
import 'package:myapp/components/social_button.dart';
import 'package:myapp/utils/config.dart';
import 'package:myapp/utils/text.dart';
// import 'package:velocity_x/velocity_x.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppText.enText['welcome_text']!,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Config.spaceSmall,
            Text(
              AppText.enText['signUp_text']!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Image.asset(
                "assets/images/welcome.png",
                height: 100,
                width: 100,
                fit: BoxFit.fitWidth,
              ),
            ),
            Config.spaceSmall,
            LoginForm(),
            Config.spaceSmall,
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppText.enText['forgot-password']!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
            ),
            const Spacer(),
            Center(
              child: Text(
                AppText.enText['social-login']!,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Config.spaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialButton(social: 'facebook'),
                SocialButton(social: 'google')
              ],
            )
          ],
        )),
      ),
    );
  }
}
