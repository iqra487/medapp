import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/components/login_form.dart';
import 'package:myapp/components/sign_up_form.dart';
import 'package:myapp/components/social_button.dart';
import 'package:myapp/utils/config.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:myapp/utils/text.dart';

import '../../components/FadeAnimation.dart';
import 'docloginform.dart';

class DocLogin extends StatelessWidget {
  const DocLogin({super.key});

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
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      const Text(
                        "Welcome Back",
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
                                      // blurRadius: 20,
                                      // offset: Offset(0, 10))
                                    )
                                  ]),
                              child: Column(
                                children: <Widget>[DocLoginForm()],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.5,
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Config.primaryColor),
                              ),
                            )),
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
