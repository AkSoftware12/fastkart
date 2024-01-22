import 'dart:convert' show json, jsonDecode, jsonEncode;
import 'package:loginapp/Screens/Model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/DataBase/database.dart';
import 'package:loginapp/Screens/HomeDrawer/home.dart';
import 'package:loginapp/Screens/Model/cart.dart';

void main() => runApp(OrderNow());

class OrderNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        // ignore: unnecessary_null_comparison
        title: const Text(
          'Place Order',
          style: TextStyle(
            color: const Color(
                0xffdd9d39), // Color for the second part of the text
          ),
        ),
        automaticallyImplyLeading: true,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Use Navigator to go back
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.black, // Change this color to your desired color.
        ),
      ),

      body: Center(child: OrderForm()),
    );
  }
}

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String address = "";
  String pinCode = "";
  String payment_option = "cod";
  String delivery_option = "standard_delivery";
  String buy = "from_wishlist";

  bool isCashOnDelivery = true;
  bool isStandardDelivery = true;
  bool isBuyOption = true;
  bool isDebitCardSelected = false;

  CartDatabaseHelper dbHelper = CartDatabaseHelper();
 List<CartItem> products =[];

  @override
  void initState() {
    super.initState();
    dbHelper.getCartItems().then((items) {
      setState(() {
        products = items;
      });
    });
  }

  Widget bottomBarButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xffdd9d39),
            ), // Change the color to your desired color
          ),
          onPressed: () {
            _showProgressBar();
            order();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return OrderScreen();
            //     },
            //   ),
            // );
          },
          child: const Text("Place Order"),
        ),
      ),
    );
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





  Future<void> order() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token') ?? '';
    // Encode the List of Maps to a JSON string
    List<Map<String, dynamic>> cartItemMaps = products.map((item) => item.toMap()).toList();
    String cartItemsJSON = json.encode(cartItemMaps);
    try {
      final Uri uri = Uri.parse('https://fastkart.akdesire.com/api/place-order');

      final item = {
        "products":cartItemsJSON,
        "address": address,
        "pincode": pinCode,
        "payment_option": payment_option,
        "delivery_option": delivery_option,
        "buy": buy,
        // Add more body parameters as needed.
      };

      final headers = {
        'Content-Type': 'application/json',
        'Authorization':  token,
      };


      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(item),
      );
      if (response.statusCode == 200) {
        _hideProgressBar();
        var products = jsonDecode(response.body.toString());
        if (products['status'] == 201) {
          _showMyDialog(context);
        } else {
          print('products: ${response.body}');
          print('data: ${response.body}');
        }
      } else {
        print('failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(125),
              height: 150,
              width: 150,
              decoration: new BoxDecoration(
                color: Colors.white24,
                image: DecorationImage(
                  image: new AssetImage(
                    'assets/orders.png',
                  ),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Delivery Address:',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your address',
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Pin Code:',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  pinCode = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter pin code',
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Payment Method:',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: true,
                    groupValue: isCashOnDelivery,
                    onChanged: (value) {
                      setState(() {
                        isCashOnDelivery = value!;
                        // isDebitCardSelected = !value;
                      });
                    },
                  ),
                  Text('Cash on Delivery'),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Radio(
              //       value: true,
              //       groupValue: isDebitCardSelected,
              //       onChanged: (value) {
              //         setState(() {
              //           isDebitCardSelected = value!;
              //           isCashOnDelivery = !value;
              //         });
              //       },
              //     ),
              //     Text('Debit Card'),
              //   ],
              // ),
            ],
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Delivery Option:',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: true,
                    groupValue: isStandardDelivery,
                    onChanged: (value) {
                      setState(() {
                        isStandardDelivery = value!;
                        // isDebitCardSelected = !value;
                      });
                    },
                  ),
                  Text('Standard Delivery'),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Radio(
              //       value: true,
              //       groupValue: isDebitCardSelected,
              //       onChanged: (value) {
              //         setState(() {
              //           isDebitCardSelected = value!;
              //           isCashOnDelivery = !value;
              //         });
              //       },
              //     ),
              //     Text('Debit Card'),
              //   ],
              // ),
            ],
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Buy Option:',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: true,
                    groupValue: isBuyOption,
                    onChanged: (value) {
                      setState(() {
                        isBuyOption = value!;
                        // isDebitCardSelected = !value;
                      });
                    },
                  ),
                  Text('Buy'),
                ],
              ),
            ],
          ),
          if (_progressVisible)
            CircularProgressIndicator() // Display progress bar if visible
          else
            GestureDetector(
              child: const Text(
                '',
              ),
            ),
          bottomBarButton(),
        ],
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0), // Customize the shape here
        ),
        title: Center(
          child: Text(
            'Order successful',
            style: GoogleFonts.sansita(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Replace 'imagePath' with the actual path to your image asset or URL
            // Image.asset('assets/login.png'),
            Center(
              child: Container(
                padding: EdgeInsets.all(100),
                height: 200,
                width: 200,
                decoration: new BoxDecoration(
                  color: Colors.white24,
                  image: DecorationImage(
                    image: new AssetImage(
                      'assets/orders.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            Center(
              child: Container(
                  // Silder banner ad  open
                  child: //  image ad open
                      Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyHomePage();
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 7.0),
                      decoration: BoxDecoration(
                        // Set the background color
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffdd9d39),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                            ),
                            child: Center(
                              child: Text(
                                'Ok',
                                style: GoogleFonts.sansita(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
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
            )
          ],
        ),
      );
    },
  );
}
