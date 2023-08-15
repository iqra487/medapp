import 'package:flutter/material.dart';
import 'package:myapp/components/button.dart';
import 'package:myapp/components/sign_up_form.dart';
import 'package:myapp/utils/config.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final storage = new FlutterSecureStorage();
  bool obsecurePass = true;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passController.text;

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Cookie':
            'csrftoken=R06LShjWPruviQkF1YFsFH8GpKMRMHE7; sessionid=1cjgapvyu2zzj7thgn1ea9yrhioer3nl'
      };

      final String loginUrl = 'http://localhost:8000/api/login/';
      final Map<String, String> data = {
        'username': email,
        'password': password,
      };

      final http.Response response = await http.post(
        Uri.parse(loginUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Login successful, navigate to the main screen
        final responseData = jsonDecode(response.body);
        print("responseData token");
        print(responseData['token']);

        await storage.write(key: 'token', value: responseData['token']);
        String tokenSavedValue = await storage.read(key: 'token') ?? "";
        print("Saved token = $tokenSavedValue");
        Navigator.of(context).pushNamed('main');
      } else {
        // Login failed, show an error message
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['message'] ?? 'Login failed';
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
                  enabledBorder: const OutlineInputBorder(
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
                title: 'Login',
                width: 150,
                disable: false,
                onPressed: _handleLogin)
          ],
        ));
  }
}
