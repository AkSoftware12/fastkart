import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:loginapp/model/data_image.dart';

void main() {
  runApp(const MaterialApp(
    home: MyListView(),
  ));
}

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  late List<DataImage> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://api.slingacademy.com/v1/sample-data/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<DataImage> loadedImages = [];

      for (var item in data) {
        loadedImages.add(DataImage.fromJson(item));
      }

      setState(() {
        posts = loadedImages;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Integration Demo'),
      ),
      body: posts == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(posts[index].photos[0].id.toString()),
                  //subtitle: Text(posts[index].id.toString()),
                );
              },
            ),
    );
  }
}
