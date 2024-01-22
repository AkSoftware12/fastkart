import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


String stringResponse = "";
Map mapResponse = "" as Map;
Map dataResponse = "" as Map;

// List listResponse = "" as List;
class DataPassScreen extends StatefulWidget {
  final String email;
  final String img;
  final String image;
  final String last;

  const DataPassScreen({
    super.key,
    required this.email,
    require,
    required this.img,
    required this.image,
    required this.last,
  });

  @override
  State<DataPassScreen> createState() => _DataPassScreenState();
}

class _DataPassScreenState extends State<DataPassScreen> {
  Future apiCall() async {
    // http.Response response;
    // response = await http.get(Uri.parse("https://fastkart.akdesire.com/api/get-products"));

    final baseUrl = 'https://fastkart.akdesire.com/api/get-category/';
    final url = Uri.parse('$baseUrl${widget.email}');

    final response = await http.get(url);


    if (response.statusCode == 200) {

      // String title = mapResponse['title'];
      setState(() {
      // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        dataResponse=mapResponse['data'];
       // listResponse = mapResponse['data'];
     //  email = mapResponse['email'];
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
      appBar: AppBar(
        title: Text('Data Pass Screen'),
      ),
      body: SingleChildScrollView(
    child: Form(
    child: Column(

        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SizedBox(
          //     height: 300,
          //     width: double.infinity,
          //     child: Container(
          //       decoration: BoxDecoration(
          //           border: Border.all(
          //             color: Colors.black12,
          //           ),
          //           color: Colors.grey[100],
          //           borderRadius: const BorderRadius.all(Radius.circular(10))),
          //       child: Image.network(
          //         widget.image,
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Text(
          //    mapResponse["data"]['title'],
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Text(
          //   'Last name = ' + widget.last,
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          Text(
            'Email = ' +dataResponse['id'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    )
      )
    );
  }
}
