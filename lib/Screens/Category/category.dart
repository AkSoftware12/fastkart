import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/DataBase/database.dart';
import 'package:loginapp/Screens/Cart/cart.dart';
import 'package:loginapp/Screens/HomeDrawer/home.dart';
import 'package:loginapp/Screens/HomeScreen/homescreen.dart';
import 'package:loginapp/Screens/Model/cart.dart';
import 'package:loginapp/Screens/Model/product.dart';
import 'package:loginapp/drawer.dart';


String stringResponse = "";
Map mapResponse = "" as Map;
Map dataResponse = "" as Map;
List listResponse = "" as List;


String stringResponse1 = "";
Map mapResponse1 = "" as Map;
Map dataResponse1 = "" as Map;
List listResponsePrice = "" as List;

class CategoryScreen extends StatefulWidget {
  final int id;
  final int category;
  final String title;
  final String slug;
  final String photo;
  final String description;
  final String additional_info;
  final String care_instruction;
  final String status;
  final int price;
  final int mrp;
  final String quantity;

  const CategoryScreen({
    super.key,
    require,
    required this.id,
    required this.category,
    required this.title,
    required this.slug,
    required this.photo,
    required this.description,
    required this.additional_info,
    required this.care_instruction,
    required this.status,
    required this.price,
    required this.mrp,
    required this.quantity,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // final CartDatabase _cartDatabase = CartDatabase();
  CartDatabaseHelper dbHelper = CartDatabaseHelper();
  int selectedItemIndex = -1;





  bool showFullDescription = false;
  bool showFullAdditional = false;
  bool showFullInstruction = false;
  String selectedItemText = '';





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


  Future apiCall() async {
    // http.Response response;
    // response = await http.get(Uri.parse("https://reqres.in/api/users/2"));

    final baseUrl = 'https://fastkart.akdesire.com/api/get-category/';
    final url = Uri.parse('$baseUrl${widget.category}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];

      });
    } else {}
  }

  Future apiPrice() async {
    // http.Response response;
    // response = await http.get(Uri.parse("https://reqres.in/api/users/2"));

    final baseUrl = 'https://fastkart.akdesire.com/api/get-product-price/';
    final url = Uri.parse('$baseUrl${widget.id}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        mapResponse1 = json.decode(response.body);
        listResponsePrice = mapResponse1['data'];

      });
    } else {}
  }

  @override
  void initState() {
    apiCall();
    apiPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // ignore: unnecessary_null_comparison
        title: const Text(
          'Details Product',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image top open
            Center(
              child: SizedBox(
                height: 250,
                child: Image.network(
                  'https://fastkart.akdesire.com' + widget.photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // image top close
            // Replace with your image asset
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title text and active text open
                  Row(children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        widget.title,maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        ('(' + widget.status + ')'),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 8),
                  // title text and active text close

                  // sub title
                  Text(
                    widget.slug,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),





                  Row(
                    children: [
                         selectedItemIndex != -1
                            ? Text('₹ ${listResponsePrice[selectedItemIndex]['price']}',
                           textAlign: TextAlign.start,
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                           style: GoogleFonts.sansita(
                             textStyle: TextStyle(
                                 color: Colors.redAccent,
                                 fontSize: 24,
                                 fontWeight:
                                 FontWeight.bold),
                           ),)
                            : Text('₹ ${listResponsePrice[0]['price']}',
                           textAlign: TextAlign.start,
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                           style: GoogleFonts.sansita(
                             textStyle: TextStyle(
                                 color: Colors.redAccent,
                                 fontSize: 24,
                                 fontWeight:
                                 FontWeight.bold),
                           ),),

                      Stack(
                        children: [
                          selectedItemIndex != -1
                              ? Text('/ ₹ ${listResponsePrice[selectedItemIndex]['mrp']}',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.sansita(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight:
                                  FontWeight.bold),
                            ),)
                              :Text('/ ₹ ${listResponsePrice[0]['mrp']}',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.sansita(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight:
                                  FontWeight.bold),
                            ),),
                          Positioned(
                              top: 0,
                              left: 5,
                              right: 0,
                              bottom: 1,
                              child: Image.network(
                                'https://www.linkpicture.com/q/line_2.png',
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    ],
                  ),

                  // quantity list open


                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                        itemCount: listResponsePrice.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index)
                        {

                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedItemIndex ==index) {
                                    selectedItemIndex = index;

                                    // Unselect the item if it's already selected
                                  } else {

                                    selectedItemIndex = index;
                                    // Select the item
                                  }
                                });
                              },

                              child:Card(
                                elevation: 4.0,
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                                  child: Center(
                                    child: Text(
                                      listResponsePrice[index]['quantity'].toString(),
                                      style: GoogleFonts.sansita(
                                        textStyle: TextStyle(

                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )

                          );
                        }
                    ),
                  ),





                  // quantity list close

                  // Description text open
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    showFullDescription
                        ? (widget.description)
                        : (widget.description),
                    maxLines: showFullDescription
                        ? null
                        : 4, // Show only 4 lines initially
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .white), // Change the color to your desired color
                      ),
                      onPressed: () {
                        setState(() {
                          showFullDescription = !showFullDescription;
                        });
                      },
                      child: Text(
                        showFullDescription ? 'Less' : 'More',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  // Description text close

                  // additional text open
                  Text(
                    'additional_info:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    showFullAdditional
                        ? (widget.additional_info)
                        : (widget.additional_info),
                    maxLines: showFullAdditional
                        ? null
                        : 4, // Show only 4 lines initially
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .white), // Change the color to your desired color
                      ),
                      onPressed: () {
                        setState(() {
                          showFullAdditional = !showFullAdditional;
                        });
                      },
                      child: Text(
                        showFullAdditional ? 'Less' : 'More',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  // additional text close


                  // Instruction text open
                  Text(
                    'care_instruction:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    showFullInstruction
                        ? (widget.care_instruction)
                        : (widget.care_instruction),
                    maxLines: showFullInstruction
                        ? null
                        : 4, // Show only 4 lines initially
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .white), // Change the color to your desired color
                      ),
                      onPressed: () {
                        setState(() {
                          showFullInstruction = !showFullInstruction;
                        });
                      },
                      child: Text(
                        showFullInstruction ? 'Less' : 'More',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  // Instruction text close

                  // related producte list open
                  Text(
                    'Related Products:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      // Replace with your number of related products
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150,
                          margin: EdgeInsets.only(right: 12),
                          child: Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                SvgPicture.network(
                                  mapResponse['base_url'] +
                                      listResponse[0]['photo'],
                                  width: 100,
                                  height: 120,
                                ),
                                // Image.network(
                                //   mapResponse1['base_url'] +
                                //       listResponse1[index]['photo'],
                                //   fit: BoxFit.cover,
                                // ), // Replace with related product image
                                Text(
                                  listResponse[0]['title'].toString(),
                                  style: GoogleFonts.sansita(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // related producte list open
                ],
              ),
            ),

            // Add to cart button open
            SizedBox(height: 16),

            if (_progressVisible)
              CircularProgressIndicator() // Display progress bar if visible
            else
              GestureDetector(
                child: const Text(
                  '',

                ),
              ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffdd9d39),), // Change the color to your desired color
                  ),
                  onPressed: () {
                    _addToCart();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                  child: Text('Add to Cart',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),
              ),
            ),
            // Add to cart button close
          ],
        ),
      ),
    );
  }

  Future<void> _addToCart() async {
    final cartItem = CartItem(product_id:widget.id,price: widget.price.toDouble(), quantity: 1, image: widget.photo, title: widget.title, mrp: widget.mrp.toDouble(), theme: '2', weight:widget.quantity, vendor: '',);
    await dbHelper.insertCartItem(cartItem);

    // Show a snackbar or any other feedback to the user
  }
}
