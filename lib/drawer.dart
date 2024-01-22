import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/Screens/Setting/setting.dart';
import 'package:loginapp/ui/datapass.dart';
import 'package:loginapp/ui/gridDashboard.dart';
import 'package:loginapp/ui/profile.dart';

void main() {
  runApp(const MaterialApp(
    home: DrawerScreen(),
  ));
}

String stringResponse = "";
Map mapResponse = "" as Map;
Map dataResponse = "" as Map;

List listResponse = "" as List;

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  _MyListViewState createState() => _MyListViewState();
}


class _MyListViewState extends State<DrawerScreen> {

  final Color customAppBarColor = Color(0xFF000000);


  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://fastkart.akdesire.com/api/get-products"));


    if (response.statusCode == 200) {

      // final String email = mapResponse['email'];
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
        // email = mapResponse['email'];
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  void openBrowserLink() async {
    const url = 'https://youtub.com'; // Replace with your desired URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              // leading: CircleAvatar(
              //   backgroundImage: NetworkImage(completeUrl),
              // ),
              title: Text(listResponse[index]['title']),
              subtitle: Text(listResponse[index]['slug']),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataPassScreen(
                              email: listResponse[index]['id'].toString(),
                              img: listResponse[index]['slug'],
                              image: listResponse[index]['photo'],
                              last: listResponse[index]['description'],
                            )));

              },
            ),
          );
        },
      ),


      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        // leading: Icon(Icons.menu),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this color to your desired color
        ),
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.personal_injury_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileUploadScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
        ],
        backgroundColor: customAppBarColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Ravikant"),
              accountEmail: Text("ravikantsaini03061996@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/men.jpg'), // Set your header image path here
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GridDashboard(),
                  ),
                );
                // Add your action here when the Home item is tapped.
                // Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
                // Add your action here when the Settings item is tapped.
                // Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Yotube'),
              onTap: () {
                openBrowserLink();
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Add your action here when the About item is tapped.
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),

      // body: _pages[_currentIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //
      //   backgroundColor: Color(0xFF000000),
      //   selectedItemColor: Colors.blue, // Set the selected item color
      //   unselectedItemColor: Colors.white, // Set the unselected item color
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}
