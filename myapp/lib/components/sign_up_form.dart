import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/components/button.dart';
import 'package:myapp/utils/config.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert';

import '../screens/home_page.dart';

class SignUpForm extends StatefulWidget {
  // const SignUpForm({super.key});

  SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final storage = new FlutterSecureStorage();

  bool obsecurePass = true;

  Future<void> handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      final String username = _nameController.text;
      final String email = _emailController.text;
      final String password = _passController.text;

      final Map<String, String> data = {
        'username': username,
        'email': email,
        'password': password,
      };

      final registrationUrl = 'http://localhost:8000/api/register/';

      try {
        final response = await http.post(
          Uri.parse(registrationUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final user = responseData['user'];
          final token = responseData['token'];
          print("token: $token");
          await storage.write(key: 'token', value: responseData['token']);
          String tokenSavedValue = await storage.read(key: 'token') ?? "";
          print("Saved token = $tokenSavedValue");
          // widget.onSignUpSuccess(userName);

          // Store the token securely

          // Navigate to the main screen
          Navigator.of(context).pushNamed('main');
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => HomePage(
          //       username: userName,
          // Pass any other data you need here
          //     ),
          //   ),
          // );
        } else {
          // Registration failed, show an error message
          final responseData = jsonDecode(response.body);
          final errorMessage = responseData['message'] ?? 'Sign up failed';
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (error) {
        print('Error during registration: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Username',
                  labelText: 'Username',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person_2_outlined),
                  prefixIconColor: Colors.black38),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
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
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Password',
                  labelText: 'Password',
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
                width: 150,
                title: 'Sign Up',
                disable: false,
                onPressed: handleSignUp)
          ],
        ));
  }
}
