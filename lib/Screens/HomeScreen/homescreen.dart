import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/DataBase/database.dart';
import 'package:loginapp/Screens/Category/category.dart';
import 'package:loginapp/Screens/Model/cart.dart';
import 'package:loginapp/model/home_model.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

// Product list object
String stringResponse = "";
Map mapResponse = "" as Map;
Map dataResponse = "" as Map;
List listResponse = "" as List;

// category list object
Map mapResponse1 = "" as Map;
Map dataResponse1 = "" as Map;
List listResponse1 = "" as List;
List listResponse2 = "" as List;

// category list object
Map mapResponseBanner = "" as Map;
Map dataResponseBanner = "" as Map;
List listResponseBanner = "" as List;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<HomeScreen> {
  CartDatabaseHelper dbHelper = CartDatabaseHelper();
  late List<Map<HomeModel, Object>> list;
  final Color customAppBarColor = Color(0xFF000000);

  Future apiCall() async {
    http.Response response;
    response = await http
        .get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'] as List;
      });
    }
  }
  //
  // Future apiCategoryList() async {
  //   http.Response response;
  //   response = await http
  //       .get(Uri.parse("https://fastkart.akdesire.com/api/get-categorylist"));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       mapResponse1 = json.decode(response.body);
  //       listResponse1 = mapResponse1['data'];
  //       listResponse2 = mapResponse1['product_price'];
  //     });
  //   }
  // }
  //
  // Future apiBannerList() async {
  //   http.Response response;
  //   response = await http
  //       .get(Uri.parse("https://fastkart.akdesire.com/api/get-bannerlist"));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       mapResponseBanner = json.decode(response.body);
  //       listResponseBanner = mapResponseBanner['data'];
  //       // listResponse2 = mapResponse1['product_price'];
  //     });
  //   }
  // }

  @override
  void initState() {
    apiCall();
    // apiCategoryList();
    // apiBannerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x38D7A4DA),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Container(
                  // Silder banner ad  open
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 150.0,
                        // Set the height as per your requirements
                        viewportFraction: 0.99,
                        // Adjust the viewport fraction
                        aspectRatio: 16 / 9,
                        // Adjust the aspect ratio
                        // enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        // itemMargin: 10.0, // Set the horizontal space between items
                      ),
                      items: listResponseBanner.map((index) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 200,
                              child: Container(
                                width: double.infinity,
                                // Set the width of the container
                                height: 150,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                // Set the height of the container
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  // Set the background color
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: SizedBox(
                                  height: 150,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        mapResponseBanner['base_url'] +
                                            listResponseBanner[0]
                                                ['center_photo'],
                                        fit: BoxFit.fill,
                                      )
                                      // Image scaling mode
                                      ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  // slider banner ad close
                ),
              ),
              SizedBox(
                height: 150,
                child: Container(
                  // Silder banner ad  open
                  child: //  image ad open
                      Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      margin: EdgeInsets.symmetric(horizontal: 7.0),
                      decoration: BoxDecoration(
                        color: Colors.blue, // Set the background color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SizedBox(
                          height: 150,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                'https://www.linkpicture.com/q/IMG_20231001_170052.jpg',
                                fit: BoxFit.fill,
                              ))
                          // Image scaling mode
                          ),
                    ),
                  ),
                  // image ad close

                  // slider banner ad close
                ),
              ),
              SizedBox(
                height: 220,
                child: Container(

                    // Silder banner ad  open
                    child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 20,
                    ),
                    child: Column(children: [
                      Row(children: [
                        Text(
                          'Category',
                          style: GoogleFonts.sansita(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: double.infinity,
                      height: 150,

                      margin: EdgeInsets.symmetric(horizontal: 7.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Set the background color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // child: Image.network(
                      //   'https://www.linkpicture.com/q/IMG_20230929_182807.jpg',
                      //   fit: BoxFit.cover,
                      // ),
                      child: SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: listResponse1.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Adjust the value as needed
                              ),
                              margin: EdgeInsets.all(10),
                              child: SizedBox(
                                height: 100,
                                width: 150,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5.0,
                                        top: 10,
                                      ),
                                      child: Column(children: [
                                        Row(children: [
                                          Text(
                                            listResponse1[index]['title']
                                                .toString(),
                                            style: GoogleFonts.sansita(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ]),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            height: 60,

                                            child: SvgPicture.network(
                                              mapResponse1['base_url'] +
                                                  listResponse1[index]['photo'],
                                              width: 100,
                                              height: 60,
                                            ),

                                            // child: Image.network(
                                            //   mapResponse1['base_url'] +
                                            //       listResponse1[index]['photo'],
                                            //
                                            // )
                                          ),
                                        ),
                                      ]),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ]) //  image ad open
                    //  category list open

                    // category list close
                    // image ad close

                    // slider banner ad close
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 20,
                ),
                child: Column(children: [
                  Row(children: [
                    Text(
                      'Product',
                      style: GoogleFonts.sansita(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ]),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: listResponse.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryScreen(
                                id: listResponse[index]['id'],
                                category: listResponse[index]['category'],
                                title: listResponse[index]['title'],
                                slug: listResponse[index]['slug'],
                                photo: listResponse[index]['photo'],
                                description: listResponse[index]['description'],
                                additional_info: listResponse[index]
                                    ['additional_info'],
                                care_instruction: listResponse[index]
                                    ['care_instruction'],
                                status: listResponse[index]['status'],
                                price: listResponse[index]['product_price']
                                    ['price'],
                                mrp: listResponse[index]['product_price']
                                    ['mrp'],
                                quantity: listResponse[index]['product_price']
                                    ['quantity'],
                              ),
                            ),
                          );
                        },
                        child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Adjust the value as needed
                            ),
                            margin: EdgeInsets.all(10),
                            child: SizedBox(
                              height: 155,
                              width: 50,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          height: 120,
                                          width: 150,
                                          child: Card(
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Adjust the value as needed
                                            ),
                                            child: SizedBox(
                                                height: 60,
                                                width: 50,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Image.network(
                                                      mapResponse['base_url'] +
                                                          listResponse[index]
                                                              ['photo'],
                                                    ))
                                                // Image scaling mode
                                                ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 80,
                                        child: SizedBox(
                                          height: 80,
                                          width: 100,
                                          child: Card(
                                              elevation: 6.0,
                                              margin: EdgeInsets.all(15.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20.0), // Adjust the value as needed
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: Image.network(
                                                    'https://fastkart.akdesire.com/storage/photos/organic/products/17.png',
                                                    fit: BoxFit.cover,
                                                  ))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 22.0),
                                      child: Stack(children: [
                                        Container(
                                          width: 220,
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 3.0,
                                            ),
                                            child: Column(children: [
                                              Column(children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 110,
                                                      child: Text(
                                                        listResponse[index]
                                                            ['title'],
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style:
                                                            GoogleFonts.sansita(
                                                          textStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      listResponse[index]['slug'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.sansita(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 9,
                                                            fontWeight: FontWeight
                                                                .normal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '₹ ' +
                                                          listResponse[index][
                                                                      'product_price']
                                                                  ['price']
                                                              .toString(),
                                                      textAlign: TextAlign.start,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.sansita(
                                                        textStyle: TextStyle(
                                                            color:
                                                                Colors.redAccent,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                    Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: Text(
                                                            '/  ₹ ' +
                                                                listResponse[index]
                                                                            [
                                                                            'product_price']
                                                                        ['mrp']
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: GoogleFonts
                                                                .sansita(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
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
                                                Row(
                                                  children: [
                                                    Text(
                                                      ' ' +
                                                          listResponse[index][
                                                                      'product_price']
                                                                  ['quantity']
                                                              .toString(),
                                                      textAlign: TextAlign.start,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.sansita(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            ]),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 70.0, left: 120.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          final cartItem = CartItem(product_id:listResponse[
                                                                index]['id'],
                                                            price: listResponse[index]['product_price']['price'].toDouble(), quantity: 1, image: listResponse[index]['photo'], title: listResponse[index]['title'], mrp: listResponse[index]['product_price']['mrp'].toDouble(), theme: '2', weight: listResponse[index]['product_price']['quantity'], vendor: '',);
                                                          await dbHelper.insertCartItem(cartItem);
                                                        },
                                                        child: const Text(
                                                          'Add to Cart',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Color(0xffdd9d39),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]))
                                      ]),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
