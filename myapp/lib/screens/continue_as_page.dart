import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/components/button.dart';
import 'package:myapp/components/login_form.dart';
import 'package:rive/rive.dart';

import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/FadeAnimation.dart';

class ContinueAs extends StatefulWidget {
  const ContinueAs({super.key});

  @override
  State<ContinueAs> createState() => _ContinueAsState();
}

class _ContinueAsState extends State<ContinueAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 38, 62, 1),
      // body: Stack(children: [Blur ],),
      body: Column(
        children: [
          Container(
            height: 400,
            child: Stack(children: [
              RiveAnimation.asset(
                'assets/animations/3968-8274-girl-and-dog (2).riv',
                fit: BoxFit.fitHeight,
                alignment: Alignment.topCenter,
              ),
              Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: SizedBox(),
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SafeArea(
                    //     child: Text(
                    //   "Welcome to petcare",
                    //   style: TextStyle(
                    //       fontSize: 70,
                    //       color: Colors.white,
                    //       fontFamily: 'Poppins',
                    //       fontWeight: FontWeight.w900,
                    //       fontStyle: FontStyle.italic),
                    // )),
                    SizedBox(
                      height: 50,
                    ),
                    // Center(
                    //   child: Text(
                    //     "WELCOME TO PETCARE ",
                    //     style: TextStyle(
                    //         fontSize: 35,
                    //         color: Color.fromARGB(255, 252, 241, 206),
                    //         fontFamily: 'Poppins',
                    //         fontWeight: FontWeight.w700,
                    //         fontStyle: FontStyle.italic),
                    //   ),
                    // ),
                    SizedBox(
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Welcome To Petcare ",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    // SizedBox(
                    //   height: 200,
                    // ),
                    // Center(
                    //   child: Text(
                    //     "Continue as.. ",
                    //     style: TextStyle(
                    //         fontSize: 30,
                    //         color: Color.fromARGB(255, 246, 232, 186),
                    //         fontFamily: 'Poppins',
                    //         fontWeight: FontWeight.w700,
                    //         fontStyle: FontStyle.italic),
                    //   ),
                    // ),
                    // const SizedBox(height: 50),
                  ],
                ),
              ),
            ]),
          ),
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
                child: Column(children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  FadeAnimation(
                      1.4,
                      InkWell(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Continue as",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(28, 38, 62, 1)),
                                  ),
                                  Config.spaceSmall,
                                  InkWell(
                                      child: Container(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 5,
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          28, 38, 62, 1),
                                                  fixedSize: Size(200, 50),
                                                  shape: StadiumBorder()),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamed('doc_main');
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.arrow_right,
                                                    size: 28,
                                                  ),
                                                  SizedBox(
                                                    width: 23,
                                                  ),
                                                  "Doctor"
                                                      .text
                                                      .size(25)
                                                      .italic
                                                      .bold
                                                      .fontFamily('Poppins')
                                                      .make()
                                                ],
                                              )))),
                                  Config.spaceSmall,
                                  Center(
                                    child: InkWell(
                                        child: Container(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 5,
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            28, 38, 62, 1),
                                                    fixedSize: Size(225, 50),
                                                    shape: StadiumBorder()),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed('login');
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .arrow_right,
                                                      size: 28,
                                                    ),
                                                    SizedBox(
                                                      width: 23,
                                                    ),
                                                    "Pet Owner"
                                                        .text
                                                        .size(25)
                                                        .italic
                                                        .bold
                                                        .fontFamily('Poppins')
                                                        .make()
                                                  ],
                                                )))),
                                  )
                                ])),
                      ))
                ]),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
