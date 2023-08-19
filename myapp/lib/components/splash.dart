import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _movetohome(context); // Pass the context to the method
  }

  void _movetohome(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 3000));
    Navigator.of(context).pushReplacementNamed("main");
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
