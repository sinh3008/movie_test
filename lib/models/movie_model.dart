class Movie {
  final int id;
  final String title;
  final double voteAverage;
  final String posterPath;
  final int releaseDate;
  final List<dynamic> genres;
  final String overView;

  Movie({
    required this.id,
    required this.genres,
    required this.title,
    required this.voteAverage,
    required this.posterPath,
    required this.releaseDate,
    required this.overView,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      genres: List<dynamic>.from(json['genres']),
      title: json['title'],
      voteAverage: json['rating'].toDouble(),
      posterPath: json['large_cover_image'],
      releaseDate: json['year'],
      overView: json['description_full'],
    );
  }

}
