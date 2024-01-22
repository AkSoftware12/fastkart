import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loginapp/Screens/HomeDrawer/home.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool _progressVisible = false;

  void _showProgressBar() {
    setState(() {
      _progressVisible = true;
    });

    // Add a delay of 2 seconds before allowing the text
  }
  void _hideProgressBar() {
    setState(() {
      _progressVisible = false;
    });
  }

  void login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse('https://fastkart.akdesire.com/api/login'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        _hideProgressBar();
        final token = json.decode(response.body)['token'];
        var data = jsonDecode(response.body.toString());
        // save token
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        await sharedPreferences.setString('access_token', token);

      //  print(data['data']);
        if (data['status'] == 201) {
          // final scaffold = ScaffoldMessenger.of(context);
          // scaffold.showSnackBar(
          //   SnackBar(
          //     content: const Text("You are successfully loged in"),
          //   ),
          // );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ),
          );
        } else {
          print(data['data']);
          final scaffold = ScaffoldMessenger.of(context);
          scaffold.showSnackBar(
            SnackBar(
              content:
              const Text("Invalid email or password please try again !!!"),
            ),
          );
        }
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Form(
        key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return "Invalid email";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding/2),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return "Password must be at least 6 characters long";
                }
                return null;
              },

            ),
          ),
          const SizedBox(height: defaultPadding),
          if (_progressVisible)
            CircularProgressIndicator() // Display progress bar if visible
          else
            GestureDetector(
              child: const Text(
                '',

              ),
            ),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (!isValid) {
                  return;
                }

                print("Email: ${emailController.text}");
                print("Password: ${passwordController.text}");
                _showProgressBar();
                login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
        )
    );
  }
}
