import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginapp/Screens/Cart/cart.dart';
import 'package:loginapp/Screens/HomeScreen/homescreen.dart';
import 'package:loginapp/Screens/Login/login_screen.dart';
import 'package:loginapp/Screens/Profile/profile.dart';
import 'package:loginapp/Screens/Setting/setting.dart';
import 'package:loginapp/Screens/Signup/signup_screen.dart';
import 'package:loginapp/Screens/Welcome/welcome_screen.dart';
import 'package:loginapp/util/constants.dart';


void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late List<Map<String, Object>> _pages;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    _pages = [
      {
        page: const HomeScreen(),
        title: categories,
      },
      {
        page: const HomeScreen(),
        title: yourFavoritesText,
      },

      {
        page:  ProfilePage(),
        title: categories,
      },
      {
        page: CartScreen(),
        title: categories,
      },
      {
        page: SettingsScreen(),
        title: categories,
      },
    ];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Replace 'imagePath' with the actual path to your image asset or URL
              // Image.asset('assets/login.png'), // Use Image.network() for network images
              SizedBox(height: 10),
              Text('This is your image dialog content.'),
            ],
          ),
          actions: <Widget>[

            TextButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  SignUpScreen(),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Widget bottomBarTitle() {
    return Stack(
      children:[
        Container(
          color: Colors.transparent, // Use a transparent color
        ),
       Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
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
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => GridDashboard(),
                  //   ),
                  // );
                  // Add your action here when the Home item is tapped.
                  // Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SettingsScreen(),
                  //   ),
                  // );
                  // Add your action here when the Settings item is tapped.
                  // Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Yotube'),
                onTap: () {

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
      ]

    );
  }


  @override
  Widget build(BuildContext context) {

    var selectedPage = _pages[_selectedPageIndex];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RichText(
          text: TextSpan(
            text: 'Fast',
            style: GoogleFonts.aBeeZee( // Replace with your desired Google Font
              textStyle: const TextStyle(
                color: Color(0xffdd9d39),
                fontSize: 24, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Adjust font weight as needed
                // Adjust font color as needed
              ),
            ),

            children: const <TextSpan>[
              TextSpan(
                text: 'Kart.',
                style: TextStyle(
                  color: Colors.black, // Color for the second part of the text
                ),
              ),

            ],
          ),
        ),
        centerTitle: true,
        // title:  Text('Fast kart', style: appBarTitleStyle),
        // Center the title
        // titleSpacing: 0.0,

        actions: [

          IconButton(
            icon: Icon(Icons.personal_injury_outlined),
            onPressed: () {

              _showMyDialog(context);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => WelcomeScreen(),
              //   ),
              // );
            },
          ),

        ],
        iconTheme: IconThemeData(
          color: Colors.black, // Change this color to your desired color.
        ),
      ),




      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.white,
                leading: Container(),
                title:Text('Menu',style: GoogleFonts.poppins( // Replace with your desired Google Font
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24, // Adjust font size as needed
                    fontWeight: FontWeight.bold, // Adjust font weight as needed
                    // Adjust font color as needed
                  ),
                ),
                ),
                centerTitle: false,

                // title:  Text('Fast kart', style: appBarTitleStyle),
                // Center the title
                // titleSpacing: 0.0,

                actions: [

                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                ],
                iconTheme: const IconThemeData(
                  color: Colors.black, // Change this color to your desired color.
                ),
              ),
              // Divider(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: (() {
                    // Navigator.pop(
                    //	 context,
                    //	 new MaterialPageRoute(
                    //		 builder: (context) => new HomePageMain()));
                  }),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Home",
                        style: GoogleFonts.poppins( // Replace with your desired Google Font
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 22, // Adjust font size as needed
                            fontWeight: FontWeight.bold, // Adjust font weight as needed
                            // Adjust font color as needed
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: (() {
                    // Navigator.push(
                    //	 context,
                    //	 new MaterialPageRoute(
                    //		 builder: (context) => new ExploreMenuPage()));
                  }),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "About Us",
                          style: GoogleFonts.poppins( // Replace with your desired Google Font
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 22, // Adjust font size as needed
                              fontWeight: FontWeight.bold, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(
              // height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ExpansionTile(
                  title: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Product",
                        style: GoogleFonts.poppins( // Replace with your desired Google Font
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 22, // Adjust font size as needed
                            fontWeight: FontWeight.bold, // Adjust font weight as needed
                            // Adjust font color as needed
                          ),
                        ),
                      )
                    ],
                  ),

                  childrenPadding: EdgeInsets.only(left: 25), // children padding
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: (() {
                          // Navigator.push(
                          //	 context,
                          //	 new MaterialPageRoute(
                          //		 builder: (context) => new VendorVenuePage()));
                        }),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Vegetables & Fruit",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: (() {
                          // Navigator.push(
                          //	 context,
                          //	 new MaterialPageRoute(
                          //		 builder: (context) =>
                          //			 new VendorPhotographerPage()));
                        }),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [

                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Milk & Dairies",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: (() {
                          // Navigator.push(
                          //	 context,
                          //	 new MaterialPageRoute(
                          //		 builder: (context) =>
                          //			 new VendorCenematographyPage()));
                        }),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [

                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Grocery & Staples",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                    //more child menu
                  ],
                ),
              ),

              ExpansionTile(
                title: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Mega Menu",
                      style: GoogleFonts.poppins( // Replace with your desired Google Font
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 22, // Adjust font size as needed
                          fontWeight: FontWeight.bold, // Adjust font weight as needed
                          // Adjust font color as needed
                        ),
                      ),
                    )
                  ],
                ),

                childrenPadding: EdgeInsets.only(left: 1), // children padding
                // ignore: prefer_const_literals_to_create_immutables
                children: [

                   Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Daily Staples",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 22, // Adjust font size as needed
                                  fontWeight: FontWeight.bold, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Top Save Products",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 22, // Adjust font size as needed
                                  fontWeight: FontWeight.bold, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),

                  // sub title list

                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Fresh Brown Coconut",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Tuffets Britannia Cheezze",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Tuffets Britannia Cheezze",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Fresh Brown Coconut",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Tuffets Britannia Cheezze",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Green Lettuce ",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  // sub title list close

                // recently title
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Recently Added Products",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 22, // Adjust font size as needed
                                  fontWeight: FontWeight.bold, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  // recently title

                  // recently subtitle list
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Good Life Refired Sunflower Oil",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Green Capsicum",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Green Lettuce ",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Organic Green Lemon",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Fresh Brown Coconut",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: GestureDetector(
                      onTap: (() {
                        // Navigator.push(
                        //	 context,
                        //	 new MaterialPageRoute(
                        //		 builder: (context) => new ExploreMenuPage()));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Organic Fresh Strawberry ",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    ),
                  ),

                  //more child menu
                ],
              ),

              // SizedBox(
              // height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: (() {
                    // Navigator.push(
                    //	 context,
                    //	 new MaterialPageRoute(
                    //		 builder: (context) => new DrawerPackages()));
                  }),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Contact",
                          style: GoogleFonts.poppins( // Replace with your desired Google Font
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 22, // Adjust font size as needed
                              fontWeight: FontWeight.bold, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ExpansionTile(
                  title: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Seller",
                        style: GoogleFonts.poppins( // Replace with your desired Google Font
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 22, // Adjust font size as needed
                            fontWeight: FontWeight.bold, // Adjust font weight as needed
                            // Adjust font color as needed
                          ),
                        ),
                      )
                    ],
                  ),

                  childrenPadding: EdgeInsets.only(left: 25), // children padding
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: (() {
                          // Navigator.push(
                          //	 context,
                          //	 new MaterialPageRoute(
                          //		 builder: (context) => new VendorVenuePage()));
                        }),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Become a Seller",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: (() {
                          // Navigator.push(
                          //	 context,
                          //	 new MaterialPageRoute(
                          //		 builder: (context) =>
                          //			 new VendorPhotographerPage()));
                        }),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Seller Dashboard",
                              style: GoogleFonts.poppins( // Replace with your desired Google Font
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22, // Adjust font size as needed
                                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                                  // Adjust font color as needed
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                    //more child menu
                  ],
                ),
              ),
            ],
          ),
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  const Color(0xffdd9d39),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Home",
            // Add separate backgroundColor for BottomNavigationBarItem
            // if type: BottomNavigationBarType.shifting
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_open),
            label: categories,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.photo),
            label:"Profile",
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag),
            label: "Cart",
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: "Account",
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
        onTap: (index) {
          // Open the drawer slider when the Home item is clicked
          if (index == 1) {
            _scaffoldKey.currentState?.openDrawer();
          } else {
            _selectPage(index);
          }
        },
      ),
      body: selectedPage[page] as Widget,
    );
  }
}




