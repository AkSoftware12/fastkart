import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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


  void register(String name,email, phone, password) async {
    try {
      Response response = await post(Uri.parse('https://fastkart.akdesire.com/api/register'),
          body: {'name': name,'email': email,'phone': phone, 'password': password});

      if (response.statusCode == 200) {
    
        var data = jsonDecode(response.body.toString());
        print(data['data']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {

        print('data');
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
            padding: const EdgeInsets.only(top: 40.0),
            child: TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "Name",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty || !value.contains('')) {
                  return "Invalid name";
                }
                return null;
              },
            ),
          ),
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
            padding: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Phone",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty || !value.contains('')) {
                  return "Invalid number";
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
          const SizedBox(height: defaultPadding ),

          if (_progressVisible)
            CircularProgressIndicator() // Display progress bar if visible
          else
            GestureDetector(
              child: const Text(
                '',

              ),
            ),
          ElevatedButton(
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (!isValid) {
                return;
              }
              print("Name: ${nameController.text}");
              print("Email: ${emailController.text}");
              print("Phone: ${phoneController.text}");
              print("Password: ${passwordController.text}");
              _showProgressBar();
              register(nameController.text.toString(),emailController.text.toString(),phoneController.text.toString(),
                  passwordController.text.toString());

            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
  bool isValidEmail(String email) {
    // You can use a regular expression or any other email validation method here
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  }
}