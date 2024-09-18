import 'package:flutter/material.dart';
import 'package:movies_assingment/pages/browes_screen.dart';
import 'package:movies_assingment/pages/deatails_screen.dart';
import 'package:movies_assingment/pages/serch_page.dart';
import 'package:movies_assingment/pages/watch_list_screen.dart';
import 'package:movies_assingment/utlites/movies_service.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "Home";

  const HomeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    _buildHomeContent(),
    const SearchScreen(),
    const BrowseScreen(),
    const WatchlistScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      fixedColor: Colors.amber,
      backgroundColor: Colors.black,
      iconSize: 34,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Watchlist',
          ),
        ],
      ),
    );
  }

  static Widget _buildHomeContent() {
    final MovieService movieService = MovieService();
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          _buildMovieSection('Popular Movies', movieService.getPopularMovies()),
          _buildMovieSection('New Releases', movieService.getUpcomingMovies()),
          _buildMovieSection('Recommended', movieService.getTopRatedMovies()),
        ],
      ),
    );
  }

  static Widget _buildMovieSection(String title, Future<List<dynamic>> moviesFuture) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            color: const Color(0xFF2c2c2c), // background
            child: FutureBuilder<List<dynamic>>(
              future: moviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Check Internet Connection',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var movie = snapshot.data![index];
                      return _buildMovieCard(context, movie); // Pass context for navigation
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildMovieCard(BuildContext context, dynamic movie) {
    String imageUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
    return GestureDetector(
      onTap: () {
        // Navigate to MovieDetailsScreen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movieId: movie['id'].toString()),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(imageUrl, width: 100, height: 150, fit: BoxFit.cover),
            const SizedBox(height: 5),
            Text(
              movie['title'] ?? 'No title',
              style: const TextStyle(color: Colors.white, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
