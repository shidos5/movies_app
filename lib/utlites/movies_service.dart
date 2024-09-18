import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String apiKey = 'd7c95a9d102152b63a69bdaeecdb80bd';
  final String baseUrl = 'https://api.themoviedb.org/3/movie';

  Future<List<dynamic>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/popular?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<dynamic>> getUpcomingMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/upcoming?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<dynamic>> getTopRatedMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/top_rated?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }
}
