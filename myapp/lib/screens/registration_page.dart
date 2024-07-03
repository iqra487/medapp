import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/components/login_form.dart';
import 'package:myapp/components/sign_up_form.dart';
import 'package:myapp/components/social_button.dart';
import 'package:myapp/utils/config.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:myapp/utils/text.dart';

import '../components/FadeAnimation.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromRGBO(28, 38, 62, 1),
          Color.fromARGB(255, 53, 87, 139),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      const Text(
                        "Welcome",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(79, 53, 87, 139),
                                    )
                                  ]),
                              child: Column(
                                children: <Widget>[SignUpForm()],
                              ),
                            )),
                        // SizedBox(
                        //   height: 40,
                        // ),
                        // FadeAnimation(
                        //     1.5,
                        //     InkWell(
                        //       onTap: () {},
                        //       child: Text(
                        //         "Forgot Password?",
                        //         style: TextStyle(color: Config.primaryColor),
                        //       ),
                        //     )),
                        // SizedBox(
                        //   height: 40,
                        // ),
                        // FadeAnimation(
                        //     1.6,
                        //     Container(
                        //       height: 50,
                        //       margin: EdgeInsets.symmetric(horizontal: 50),
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(50),
                        //           color: Config.primaryColor),
                        //       child: Center(
                        //         child: Text(
                        //           "Login",
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //       ),
                        //     )),
                        SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                            1.7,
                            Text(
                              "Continue with social media",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeAnimation(
                                  1.8,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        "Facebook",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FadeAnimation(
                                  1.9,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black),
                                    child: Center(
                                      child: Text(
                                        "Github",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                        // Config.spaceSmall,
                        // FadeAnimation(
                        //     1.7,
                        //     InkWell(
                        //       onTap: () {},
                        //       child: Text(
                        //         "Don't have an account?",
                        //         style: TextStyle(color: Config.primaryColor),
                        //       ),
                        //     )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
