import 'package:flutter/material.dart';
import 'package:myapp/components/button.dart';
import 'package:myapp/utils/config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  hintText: 'Email Address',
                  labelText: 'Email',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: Colors.black38),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              cursorColor: Config.primaryColor,
              decoration: InputDecoration(
                  hintText: 'Pass Address',
                  labelText: 'Pass',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.password_outlined),
                  prefixIconColor: Colors.black38,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecurePass = !obsecurePass;
                        });
                      },
                      icon: obsecurePass
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(Icons.visibility_outlined,
                              color: Colors.black38))),
            ),
            Config.spaceSmall,
            Button(
                width: double.infinity,
                title: 'Sign In',
                disable: false,
                onPressed: () {})
          ],
        ));
  }
}
