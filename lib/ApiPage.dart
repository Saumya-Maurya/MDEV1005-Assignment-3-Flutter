import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo API Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ApiPage(),
    );
  }
}

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    final String apiKey = 'aWOPkQvZ7J7wiG02SsK5KVena4jfE7Sce3THZcn_Bnk';
    final String apiUrl = 'https://api.unsplash.com/photos?client_id=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<String> imageUrls =
      List<String>.from(decodedData.map((data) => data['urls']['regular']));
      setState(() {
        _imageUrls = imageUrls;
      });
    } else {
      // Handle error
      print('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash Images'),
      ),
      body: _buildImageList(),
    );
  }

  Widget _buildImageList() {
    if (_imageUrls.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(
            _imageUrls[index],
            fit: BoxFit.cover,
          );
        },
      );
    }
  }
}
