import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginapp/DataBase/database.dart';
import 'package:loginapp/Screens/Cart/empty_cart.dart';
import 'package:loginapp/Screens/HomeDrawer/home.dart';
import 'package:loginapp/Screens/Model/cart.dart';
import 'package:loginapp/Screens/Order/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartDatabaseHelper dbHelper = CartDatabaseHelper();
  List<CartItem> cartItems = [];



  @override
  void initState() {
    super.initState();
    dbHelper.getCartItems().then((items) {
      setState(() {
        cartItems = items;
      });
    });
  }

  Widget text() {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget bottomBarTitle() {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            Row(
                children: [
                  Text(
                    '\$${calculateTotalPrice().toStringAsFixed(2)}',
                    key: ValueKey<int>(9),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFEC6813),
                    ),
                  ),
                ]

            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBarButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xffdd9d39),), // Change the color to your desired color
          ),
          onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OrderScreen();
                },
              ),
            );
          },
          child: const Text("Buy Now"),
        ),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // ignore: unnecessary_null_comparison
        title: const Text(
          'My Cart',
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          text(),
          Expanded(

            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                if(cartItems.isEmpty){
                  EmptyCart();
                }
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200]?.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),


                  child:SizedBox(
                    height: 120,
                    child: Stack(
                        children:[
                          Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                // padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:Colors.grey,
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Image.network('https://fakestoreapi.com/${cartItem.image}',
                                        // 'https://fastkart.akdesire.com' + cartItem.photo,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 145,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0,top: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cartItem.title,
                                        // product.name.nextLine,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(cartItem.weight.toString(),
                                        // controller.getCurrentSize(product),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            '₹ ' +cartItem.price.toString(),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: GoogleFonts.sansita(
                                              textStyle: TextStyle(
                                                  color:
                                                  Colors.redAccent,
                                                  fontSize: 16,
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
                                                  '/  ₹ ' +cartItem.mrp.toString(),
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
                                                        fontSize: 16,
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
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                  children:[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 63.0,left: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove,color: Color(0xFFEC6813)),
                                              onPressed: () {
                                                setState(() {
                                                  if (cartItem.quantity > 1) {
                                                    setState(() {
                                                      cartItem.quantity--;
                                                      dbHelper.updateCartItem(cartItem);
                                                    });
                                                  }
                                                });
                                              },
                                            ),
                                            Text(cartItem.quantity.toString(), style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            IconButton(
                                              splashRadius: 10.0,
                                              icon: Icon(Icons.add,color: Color(0xFFEC6813)),
                                              onPressed: () {
                                                setState(() {
                                                  cartItem.quantity++;
                                                  dbHelper.updateCartItem(cartItem);
                                                });
                                              },
                                            ),

                                          ],
                                        ),
                                      ),
                                    )
                                  ]

                              )


                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.topRight, // or Alignment.bottomEnd
                              child: Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 2,
                                child:IconButton(
                                  splashRadius: 10.0,
                                  icon: const Icon(Icons.delete,color: Color(0xFFEC6813)),
                                  onPressed: () {
                                    setState(() {
                                      cartItems.removeAt(index);
                                      dbHelper.deleteCartItem(cartItem.id!);
                                    });
                                  },
                                ),

                              ),
                            ),
                          )

                        ]

                    ),
                  ),

                );
              },
            ),
          ),
          bottomBarTitle(),
          bottomBarButton()
        ],
      ),

    );
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += (item.price * item.quantity);
    }
    return totalPrice;
  }
}
