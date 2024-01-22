import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUploadScreen extends StatefulWidget {
  const ProfileUploadScreen({super.key});

  @override
  _ProfileUploadScreenState createState() => _ProfileUploadScreenState();
}

class _ProfileUploadScreenState extends State<ProfileUploadScreen> {
  File? _image;

  Future _getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

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



  // Future<void> uploadImage() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String token = sharedPreferences.getString('access_token') ?? '';
  //   if (_image == null) {
  //     // No image selected, show an error or message
  //     return;
  //   }
  //
  //   // Replace with your API endpoint and authentication token
  //   const apiUrl = 'https://fastkart.akdesire.com/api/update-profile';
  //
  //
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {
  //       'Authorization': token,
  //     },
  //     body: {
  //       'file': await http.MultipartFile.fromPath('image', _image!.path),
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Image uploaded successfully, handle the response
  //     print('Image uploaded successfully');
  //   } else {
  //     // Error occurred, handle the error
  //     print('Error uploading image: ${response.statusCode}');
  //   }
  // }

  Future apiCall() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     String token = sharedPreferences.getString('access_token') ?? '';

    try {
      if (_image == null) {
        return;
      }

      // http.Response response;
      // response = await http
      //     .get(Uri.parse("https://fastkart.akdesire.com/api/update-profile"));
      final response = await http.get(Uri.parse('https://fastkart.akdesire.com/api/update-profile'));
      final request = http.MultipartRequest('POST', response as Uri);
      request.headers['Authorization'] = token;
          // 'Bearer 4|KmTRspfbmyf8BHNdOIx3Dquxfwmvr433MLkolOxv82209ce6'; // Replace with your user identifier

      final imageUpload =
          await http.MultipartFile.fromPath('image', _image!.path);
      request.files.add(imageUpload);

      if (response.statusCode == 200) {
        _hideProgressBar();
        print('Image uploaded successfully');
      } else {
        // Image upload failed
        _hideProgressBar();
        print('Image upload failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  // Your main content goes here
                  CircleAvatar(
                    radius: 100,
                    child: _image == null
                        ? Text('')
                        : Image.file(
                            _image!,
                            fit: BoxFit.fill,
                          ),

                    backgroundColor:
                        Color(0xFFFFFFFF), // Replace with the user's image URL
                  ),

                  Positioned(
                    top: 150, // Adjust the top position as needed
                    right: 3, // Adjust the right position as needed
                    child: GestureDetector(
                      onTap: () {
                        _getImage();
                      },
                      child: Container(
                        width: 50, // Set the width and height as needed
                        height: 50,

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/edit1.png'),
                            // Replace with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                'John Doe', // Replace with the user's name
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Phone",
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Address",
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Pin",
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "City",
                ),
              ),
              SizedBox(height: 20),
              if (_progressVisible)
                CircularProgressIndicator() // Display progress bar if visible
              else
                GestureDetector(
                  child: const Text(
                    '',
                  ),
                ),
              //
              ElevatedButton(
                // onPressed: _submit,

                onPressed: () {
                  _showProgressBar();
                  apiCall();

                  // Implement your password reset logic here
                },
                child: Text("Save "),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
