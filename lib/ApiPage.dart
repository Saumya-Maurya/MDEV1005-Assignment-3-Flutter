// Importing necessary packages
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Entry point of the application
void main() {
  runApp(const MyApp());
}

// Main application class
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo API Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ApiPage(),
    );
  }
}

// Widget for the API page
class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  _ApiPageState createState() => _ApiPageState();
}

// State class for the API page
class _ApiPageState extends State<ApiPage> {
  List<String> _imageUrls = []; // List to store image URLs

  @override
  void initState() {
    super.initState();
    _fetchImages(); // Call the function to fetch images when the page is initialized
  }

  // Function to fetch images from the Unsplash API
  Future<void> _fetchImages() async {
    const String apiKey = 'aWOPkQvZ7J7wiG02SsK5KVena4jfE7Sce3THZcn_Bnk'; //Api Key
    const String apiUrl = 'https://api.unsplash.com/photos?client_id=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<String> imageUrls =
      List<String>.from(decodedData.map((data) => data['urls']['regular']));
      setState(() {
        _imageUrls = imageUrls; // Update the image list with fetched URLs
      });
    } else {
      // Handle error if API request fails
      if (kDebugMode) {
        print('Failed to load images');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsplash Images'),
      ),
      body: _buildImageList(), // Display the image list
    );
  }

  // Function to build the list of images
  Widget _buildImageList() {
    if (_imageUrls.isEmpty) {
      return const Center(child: CircularProgressIndicator()); // Display a loading indicator if image list is empty
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: _imageUrls.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                _imageUrls[index], // Display images using the fetched URLs
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
    }
  }
}
