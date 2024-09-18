import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies_assingment/utlites/category_tile.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/movie/list?api_key=d7c95a9d102152b63a69bdaeecdb80bd&language=en-US'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        categories = data['genres'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Browse Category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 16 / 9,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryTile(
                    name: category['name'],
                    imagePath: 'assets/movies.png',
                    
                  );
                },
              ),
            ),
    );
  }
}