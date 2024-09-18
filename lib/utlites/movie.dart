class Movie {
  final String title;
  final String posterUrl;
  final String releaseDate;
  final double rating;
  final String overview;
  final int id;

  Movie({
    required this.title,
    required this.posterUrl,
    required this.releaseDate,
    required this.rating,
    required this.overview,
    required this.id,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'Unknown title',
      posterUrl: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://via.placeholder.com/500x750', // Placeholder image if poster_path is null
      releaseDate: json['release_date'] ?? 'Unknown date',
      rating: (json['vote_average'] as num).toDouble(),
      overview: json['overview'] ?? 'No overview available',
      id: json['id'],
    );
  }

  get runtime => null;

  get genres => null;
}
