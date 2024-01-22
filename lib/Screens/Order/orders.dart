

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginapp/Screens/HomeDrawer/home.dart';
import 'package:loginapp/Screens/Order/orders%20_now.dart';
import 'package:loginapp/Screens/location/map.dart';
import 'package:loginapp/const/themeColor.dart';

void main() => runApp(OrderScreen());

class OrderScreen extends StatefulWidget {

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedOption = 'Option 1';


  void handleRadioValueChange(String value) {
    setState(() {
      selectedOption = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          // ignore: unnecessary_null_comparison
          title: const Text(
            'Orders',
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


        body: Center(
            child: OrderForm()),
    );
  }
}

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1,10,10,15),
                    child: GestureDetector(
                      child: Icon(
                        CupertinoIcons.back,
                        size: 45,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    'Payment Option',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 38),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            Container(
              decoration: BoxDecoration(
                  color: Themes.color,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Themes.color)]),
              width: 245.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.local_atm,
                        color: Colors.black,
                      ),


                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        'Cash On Delivery',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => OrderNow()));
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Themes.color,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [BoxShadow(blurRadius: 2, color: Themes.color)]),
              width: 245.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.amazonPay,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        'Debit/Credit card',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (BuildContext context) => CreditCardPage()));
                  },
                ),
              ),
            ),
            SizedBox(height: 150),
            Container(
              padding: EdgeInsets.all(125),
              height: 300,
              width: 300,
              decoration: new BoxDecoration(
                color: Colors.white24,
                image: DecorationImage(
                  image: new AssetImage(
                    'assets/moto.png',
                  ),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
