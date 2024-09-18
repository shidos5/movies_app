import 'package:flutter/material.dart';
import 'package:movies_assingment/utlites/movie.dart';


class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<Movie> watchlist = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
   
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                final movie = watchlist[index];
                return WatchlistTile(
                  title: movie.title,
                  releaseYear: movie.releaseDate.substring(0, 4),
                  imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterUrl}',
                  actors: 'Rosa Salazar, Christoph Waltz', // Example actors
                );
              },
            ),
    );
  }
}

class WatchlistTile extends StatelessWidget {
  final String title;
  final String releaseYear;
  final String imageUrl;
  final String actors;

  const WatchlistTile({
    super.key,
    required this.title,
    required this.releaseYear,
    required this.imageUrl,
    required this.actors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                top: 5,
                left: 5,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  releaseYear,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  actors,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
