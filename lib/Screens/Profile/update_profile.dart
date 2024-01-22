import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginapp/Screens/HomeDrawer/home.dart';
import 'package:loginapp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


// Product list object
String stringResponse = "";
Map mapResponse = "" as Map;
Map dataResponse = "" as Map;
List listResponse = "" as List;

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});


  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<UpdateProfilePage>
    with SingleTickerProviderStateMixin {

  String name = "";
  String email = "";
  String phone = "";
  String address = "";
  String pincode = "";
  String experience = "";


  @override
  void initState() {

    super.initState();
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


  Future<void> updateProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token') ?? '';

    try {
      final Uri uri = Uri.parse('https://fastkart.akdesire.com/api/update-profile');
          // You can include headers or other data as needed
          final item = {
      "name":name,
      "phone": phone,
      "pincode": pincode,
      "email": email,
      "present_address": address,
      "experience": experience,
      // Add more body parameters as needed.
      };

      final headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(item),
      );
      if (response.statusCode == 200) {
        _hideProgressBar();
        var data = jsonDecode(response.body.toString());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MyHomePage();
            },
          ),
        );
      } else {
        print('failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          // ignore: unnecessary_null_comparison
          title: const Text(
            'UP Date Profile',
            style: TextStyle(
              color: const Color(
                  0xffdd9d39), // Color for the second part of the text
            ),
          ),
          automaticallyImplyLeading: true,

          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              ); // Use Navigator to go back
            },
          ),
          iconTheme: IconThemeData(
            color: Colors.black, // Change this color to your desired color.
          ),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Icon(
                                //    Icons.arrow_back_ios,
                                //    color: Colors.black,
                                //    size: 22.0,
                                //  ),
                                //  Padding(
                                //    padding: EdgeInsets.only(left: 25.0),
                                //    child:  Text('PROFILE',
                                //        style: TextStyle(
                                //            fontWeight: FontWeight.bold,
                                //            fontSize: 20.0,
                                //            fontFamily: 'sans-serif-light',
                                //            color: Colors.black)),
                                //  )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/as.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.only(
                                    top: 90.0, right: 100.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                              padding: EdgeInsets.only(
                                left: 25.0, right: 25.0,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: TextFormField(

                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              // controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                hintText: "Name",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.person),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(

                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              // controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.email),
                                ),
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(

                              onChanged: (value) {
                                setState(() {
                                  phone = value;
                                });
                              },
                              // controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: "Phone",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.phone),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(

                              onChanged: (value) {
                                setState(() {
                                  address = value;
                                });
                              },
                              // controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                hintText: "Address",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.holiday_village),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(

                              onChanged: (value) {
                                setState(() {
                                  pincode = value;
                                });
                              },
                              // controller: emailController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: "Pin Code",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.pin),
                                ),
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  experience = value;
                                });
                              },
                              // controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: "Experience",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.verified_user),
                                ),
                              ),
                            ),
                          ),

                          if (_progressVisible)
                            CircularProgressIndicator() // Display progress bar if visible
                          else
                            GestureDetector(
                              child: const Text(
                                '',
                              ),
                            ),
                          Container(
                            // Silder banner ad  open
                              child: //  image ad open
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      _showProgressBar();
                                   updateProfile();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 7.0),
                                      decoration: BoxDecoration( // Set the background color
                                        borderRadius: BorderRadius.circular(
                                            20.0),
                                        color: Color(0xffdd9d39),

                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15.0,),
                                            child: Center(
                                              child: Text('Save',
                                                style: GoogleFonts.sansita(
                                                  textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),


                                          // Image scaling mode
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // image ad close
                              )
                            // slider banner ad close
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }


}