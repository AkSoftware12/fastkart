import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/Screens/HomeDrawer/home.dart';
import 'package:loginapp/Screens/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool _notificationEnabled = true;
  bool _darkModeEnabled = false;


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


  Future<void> _logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token') ?? '';

    try {
      final response = await http.post(
        Uri.parse('https://fastkart.akdesire.com/api/logout'),
        // You can include headers or other data as needed
        headers: {
          'Authorization': token,
          // Replace 'Bearer' with the appropriate authentication type if needed
          'Content-Type': 'application/json',
          // Adjust the content type as needed
        },
      );

      if (response.statusCode == 200) {
        _hideProgressBar();
        // Successful logout, handle the response if needed
        var data = jsonDecode(response.body.toString());
        print(data['message']);
        print('Logout successful');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
      } else {
        // Handle error

        print('Logout failed: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: ListView(
    children: <Widget>[
    ListTile(
    title: Text('Enable Notifications'),
    trailing: Switch(
    value: _notificationEnabled,
    onChanged: (bool value) {
    setState(() {
    _notificationEnabled = value;
    });
    },
    ),
    ),
    ListTile(
    title: Text('Account'),
    trailing: Icon(Icons.arrow_forward),
    onTap: () {
    // Handle the onTap action here
    },
    ),
    ListTile(
    title: Text('Notification'),
    trailing: Icon(Icons.arrow_forward),
    onTap: () {
    // Handle the onTap action here
    },
    ),
    ListTile(
    title: Text('Appearance'),
    trailing: Icon(Icons.arrow_forward),
    onTap: () {
    // Handle the onTap action here
    },
    ),
    ListTile(
    title: Text('Privacy & Support'),
    trailing: Icon(Icons.arrow_forward),
    onTap: () {
    // Handle the onTap action here
    },
    ),
    ListTile(
    title: Text('About'),
    trailing: Icon(Icons.arrow_forward),
    onTap: () async {
      const url = 'https://www.google.com';  // Replace with the URL you want to open
      if (await canLaunch(url)) {
      await launch(url);
      } else {
      throw 'Could not launch $url';
      }
    },
    ),

      if (_progressVisible)
        CircularProgressIndicator() // Display progress bar if visible
      else
        GestureDetector(
          child: const Text(
            '',

          ),
        ),
    ListTile(
    title: Text('Logout'),
    trailing: Icon(Icons.arrow_forward),

    onTap: (){
    _showProgressBar();
    _logout();
    }

    )
    ]
    ,
    )
    ,

    );
  }
}

