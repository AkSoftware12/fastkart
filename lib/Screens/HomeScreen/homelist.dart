import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

String stringResponse = "";

// Map<dynamic, dynamic> mapResponse = "" as Map;
Map mapResponse = "" as Map;
Map dataResponse = "" as Map;
List listResponse = "" as List;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<HomeScreen> {
  final Color customAppBarColor = Color(0xFF000000);

  Future apiCall() async {
    http.Response response;
    response = await http
        .get(Uri.parse("https://fakestoreapi.com/products"));

    if (response.statusCode == 200) {
      // final baseUrl = 'https://fastkart.akdesire.com/';
      // final url = Uri.parse('$baseUrl${listResponse[index]['title']}');
      // final image = await http.get(url);

      // final String email = mapResponse['email'];
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        //  Map<String, dynamic> mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'] as List;
        // email = mapResponse['email'];
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 2, // Number of columns in the grid
          itemCount: listResponse.length, // Total number of items in the grid
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DetailsScreen(),
                //   ),
                // );
              },

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(

                    elevation: 3,
                    // Card elevation (shadow)

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    ),


                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          mapResponse['base_url']+listResponse[index]['photo'],
                          fit: BoxFit.cover,
                        )
                      // Image scaling mode
                    ),

                  ),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(listResponse[index]['id'].toString(),style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),),
                  )),
                  Text(listResponse[index]['title'].toString(),style: GoogleFonts.sansita(
                    textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),),
                  Text(listResponse[index]['slug'].toString(),style: GoogleFonts.sansita(
                    textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),),
                ],
              ),

            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1), // Each item takes 1 cell
          mainAxisSpacing: 4.0, // Spacing between columns
          crossAxisSpacing: 4.0, // Spacing between rows

        )
    );
  }
}
