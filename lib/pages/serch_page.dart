import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_assingment/pages/deatails_screen.dart';
import 'dart:convert';

import 'package:movies_assingment/utlites/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchMovies(String query) async {
    setState(() {
      _isLoading = true; 
    });

    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=d7c95a9d102152b63a69bdaeecdb80bd&query=$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'] as List;
      setState(() {
        _searchResults = data.map((item) => Movie.fromJson(item)).toList();
      });
    } else {
      print('Error fetching search results: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      appBar: AppBar(
        backgroundColor: const Color(0xff121312),
        title: const Text('Search Movies', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white), // Typed text color
              decoration: InputDecoration(
                hintText: 'Enter movie name...',
                hintStyle: const TextStyle(color: Colors.white), // Hint text color
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _searchMovies(_searchController.text);
                    }
                  },
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Border color
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _searchMovies(value);
                }
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                      ? const Center(child: Text('No results found', style: TextStyle(color: Colors.white)))
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            var movie = _searchResults[index];
                            return ListTile(
                              leading: Image.network(
                                movie.posterUrl.isNotEmpty
                                    ? movie.posterUrl
                                    : 'https://via.placeholder.com/50x75',
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(movie.title, style: const TextStyle(color: Colors.white)),
                              subtitle: Text(movie.releaseDate, style: const TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(movieId: movie.id.toString()),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
