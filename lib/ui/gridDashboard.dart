import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
String stringResponse = "";
Map mapResponse = "" as Map;
Map dataResponse = "" as Map;

List listResponse = "" as List;

class GridDashboard extends StatefulWidget {

  const GridDashboard({super.key});


  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {


  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://fastkart.akdesire.com/api/get-products"));

    String baseUrl = "https://fastkart.akdesire.com/"; // Your base URL
    String photoPath =listResponse[0]['photo'];
    Uri uri = Uri.parse(baseUrl + photoPath);
    String completeUrl = uri.toString();
    if (response.statusCode == 200) {
      // final String email = mapResponse['email'];
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
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
    var color = 0xff453658;
    return Scaffold(
     body: ListView.builder(
        itemCount: listResponse.length,
        itemBuilder: (BuildContext context, int index) {
          return card(listResponse[index], listResponse[index]['title'], context);
        },
      ),

    );
  }

    Widget card(String image, String title, BuildContext context) {
      return Card(
        color: Colors.yellow[50],
        elevation: 8.0,
        margin: EdgeInsets.all(4.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.network(
                image,
                height: MediaQuery.of(context).size.width * (3 / 4),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Text(listResponse[0]['title']

            ),
          ],
        ),
      );
    }
  }



