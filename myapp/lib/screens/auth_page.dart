import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/components/login_form.dart';
import 'package:myapp/components/sign_up_form.dart';
import 'package:myapp/components/social_button.dart';
import 'package:myapp/utils/config.dart';
import 'package:myapp/utils/text.dart';
// import 'package:velocity_x/velocity_x.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //if user already has an account or not
  bool isSignIn = true;

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
              //if user has an account then sign up text would show else register
              isSignIn
                  ? AppText.enText['signUp_text']!
                  : AppText.enText['register_text']!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // Center(
            //   child: Image.asset(
            //     "images/welcome.png",
            //     height: 100,
            //     width: 50,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Config.spaceSmall,
            //if user has an account then login form would show up else sign up
            isSignIn ? LoginForm() : SignUpForm(),
            Config.spaceSmall,
            isSignIn
                ? Center(
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppText.enText['forgot-password']!,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                  )
                : Container(),
            const Spacer(),
            //for login thru social media(google/facebook)
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
            ),
            Config.spaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //sign up or sign in option
                Text(isSignIn
                    ? AppText.enText['signUp_text']!
                    : AppText.enText['registered_text']!),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isSignIn = !isSignIn;
                      });
                    },
                    child: Text(isSignIn ? 'Sign Up' : 'Sign In'))
              ],
            )
          ],
        )),
      ),
    );
  }
}
