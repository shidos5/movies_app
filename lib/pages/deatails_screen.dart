import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies_assingment/utlites/movie.dart'; // Ensure this is the correct path

// Watchlist Global List (for demonstration purposes)
List<Movie> watchlist = [];

class MovieDetailsScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  Movie? movie;
  List<Movie> similarMovies = [];
  bool _errorOccurred = false;
  bool _isInWatchlist = false;

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
    _fetchSimilarMovies();
    _checkIfInWatchlist();
  }

  void _checkIfInWatchlist() {
    // Check if the movie is already in the watchlist
    setState(() {
      _isInWatchlist = watchlist.any((m) => m.id == widget.movieId);
    });
  }

  Future<void> _fetchMovieDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=d7c95a9d102152b63a69bdaeecdb80bd&language=en-US'),
      );

      if (response.statusCode == 200) {
        setState(() {
          movie = Movie.fromJson(jsonDecode(response.body));
          _errorOccurred = false;
        });
      } else {
        setState(() {
          _errorOccurred = true;
        });
      }
    } catch (e) {
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  Future<void> _fetchSimilarMovies() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/${widget.movieId}/similar?api_key=d7c95a9d102152b63a69bdaeecdb80bd&language=en-US'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['results'] as List;
        setState(() {
          similarMovies = data.map((item) => Movie.fromJson(item)).toList();
        });
      } else {
        print('Failed to load similar movies');
      }
    } catch (e) {
      print('Exception occurred while fetching similar movies: $e');
    }
  }

  void _addToWatchlist() {
    if (movie != null) {
      setState(() {
        watchlist.add(movie!);
        _isInWatchlist = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      appBar: AppBar(
        backgroundColor: const Color(0xff121312),
        title: const Text('Movie Details', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _errorOccurred
          ? const Center(
              child: Text('Failed to load movie details. Please try again later.',
                  style: TextStyle(color: Colors.white)))
          : movie != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        movie!.posterUrl.isNotEmpty
                            ? 'https://image.tmdb.org/t/p/w500${movie!.posterUrl}'
                            : 'https://via.placeholder.com/500x750',
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          movie!.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          movie!.overview,
                          style: const TextStyle(fontSize: 16, color: Color(0xffFFFFFF)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xffFFFFFF)),
                            const SizedBox(width: 8),
                            Text(
                              movie!.rating.toString(),
                              style: const TextStyle(color: Color(0xffFFFFFF)),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.calendar_today, color: Color(0xffFFFFFF)),
                            const SizedBox(width: 8),
                            Text(movie!.releaseDate,
                                style: const TextStyle(color: Color(0xffFFFFFF))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: _isInWatchlist
                              ? null 
                              : _addToWatchlist,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isInWatchlist
                                ? Colors.grey
                                : Colors.blue,
                          ),
                          child: Text(
                            _isInWatchlist ? 'Added to Watchlist' : 'Add to Watchlist',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'More Like This',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffFFFFFF)),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: similarMovies.length,
                          itemBuilder: (context, index) {
                            var similarMovie = similarMovies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetailsScreen(movieId: similarMovie.id.toString()),
                                  ),
                                );
                              },
                              child: Container(
                                width: 160,
                                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      similarMovie.posterUrl.isNotEmpty
                                          ? 'https://image.tmdb.org/t/p/w500${similarMovie.posterUrl}'
                                          : 'https://via.placeholder.com/120x180',
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      similarMovie.title,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffFFFFFF)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}