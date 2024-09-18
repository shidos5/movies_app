import 'package:flutter/material.dart';
import 'package:movies_assingment/utlites/movie.dart';  // Ensure this path is correct

class WatchlistProvider with ChangeNotifier {
   List<Movie> _watchlist = [];

  List<Movie> get watchlist => _watchlist;

  void addToWatchlist(Movie movie) {
    if (!_watchlist.contains(movie)) {
      _watchlist.add(movie);
      notifyListeners();
    }
  }

  void removeFromWatchlist(Movie movie) {
    _watchlist.remove(movie);
    notifyListeners();
  }

  bool isInWatchlist(String movieId) {
    return _watchlist.any((movie) => movie.id == movieId);
  }
}
