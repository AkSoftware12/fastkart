import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginapp/Screens/Profile/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



// Product list object
String stringResponse = "";
Map mapResponse = "" as Map;
Map dataResponse = "" as Map;
List listResponse = "" as List;
class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    profile();
    super.initState();
  }


  Future<void> profile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token') ?? '';

    try {
      final response = await http.post(
        Uri.parse('https://fastkart.akdesire.com/api/get-profile'),
        // You can include headers or other data as needed
        headers: {
          'Authorization': token,
          // Replace 'Bearer' with the appropriate authentication type if needed
          'Content-Type': 'application/json',
          // Adjust the content type as needed
        },
      );

      if (response.statusCode == 200) {
        // _hideProgressBar();
        // Successful logout, handle the response if needed

        print('profile successful');
       // print(data['user']);
        setState(() {
          // mapResponse = json.decode(response.body);
          // listResponse = mapResponse['user'];
          var data = jsonDecode(response.body.toString());
          dataResponse = data['user'];

        });

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => LoginScreen(),
        //   ),
        // );
      }else{

      }
    } catch (e) {
      // Handle network or other errors
      print('Error during logout: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child:  Column(
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child:  Row(
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
                                padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                     CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child:  Icon(
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
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0,),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                 const Column(
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
                                      _status ? _getEditIcon() : Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                           Container(
                            // Silder banner ad  open
                            child:     //  image ad open
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0,right: 16),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 7.0),
                                  decoration: BoxDecoration(// Set the background color
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.blue[100],

                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: Center(
                                                child: Text(dataResponse['first_name'], style: GoogleFonts.sansita(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        )
                                      // Image scaling mode
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // image ad close

                            // slider banner ad close
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            // Silder banner ad  open
                            child:     //  image ad open
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0,right: 16),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 7.0),
                                  decoration: BoxDecoration(// Set the background color
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.blue[100],

                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: Center(
                                                child: Text(dataResponse['email'], style: GoogleFonts.sansita(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      // Image scaling mode
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // image ad close

                            // slider banner ad close
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            // Silder banner ad  open
                            child:     //  image ad open
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0,right: 16),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 7.0),
                                  decoration: BoxDecoration(// Set the background color
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.blue[100],

                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: Center(
                                                child: Text(dataResponse['phone'], style: GoogleFonts.sansita(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      // Image scaling mode
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // image ad close

                            // slider banner ad close
                          ),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            // Silder banner ad  open
                            child:     //  image ad open
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0,right: 16),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 7.0),
                                  decoration: BoxDecoration(// Set the background color
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.blue[100],

                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: Center(
                                                child: Text(dataResponse['experience'].toString(), style: GoogleFonts.sansita(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      // Image scaling mode
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // image ad close

                            // slider banner ad close
                          ),
                          Container(
                            // Silder banner ad  open
                            child:     //  image ad open
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0,right: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UpdateProfilePage();
                                        },
                                      ),
                                    );
                                  },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 7.0),
                                  decoration: BoxDecoration(// Set the background color
                                    borderRadius: BorderRadius.circular(20.0),
                                    color:  Color(0xffdd9d39),

                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        height: 50,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0 , ),
                                              child: Center(
                                                child: Text('Edit', style: GoogleFonts.sansita(
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }



  Widget _getEditIcon() {
    return  GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}