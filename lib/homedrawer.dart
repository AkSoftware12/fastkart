import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeDrawer(),
    );
  }
}

class MyHomeDrawer extends StatefulWidget {
  @override
  _MyHomeDrawerState createState() => _MyHomeDrawerState();
}

class _MyHomeDrawerState extends State<MyHomeDrawer> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    TabScreen(title: 'Home', color: Colors.blue),
    TabScreen(title: 'Product', color: Colors.green),
    TabScreen(title: 'Setting', color: Colors.red),
    TabScreen(title: 'Profile', color: Colors.yellow),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Colors.blue, // Change to your desired color
        selectedLabelStyle: TextStyle(color: Colors.red), // Change to your desired text color
        unselectedLabelStyle: TextStyle(color: Colors.black), // Change to your desired text color
        fixedColor: Colors.green,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final String title;
  final Color color;

  TabScreen({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
