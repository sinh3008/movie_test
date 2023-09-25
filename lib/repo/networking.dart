import '../models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Movie?> fetchMovie(int idMovie) async {
  try {
    var url = Uri.https(
      'yts.mx',
      'api/v2/movie_details.json',
      {
        'movie_id': idMovie.toString(),
      },
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['data']['movie'];

      if (results != null) {
        return Movie(
          id: results['id'],
          title: results['title'],
          voteAverage: results['rating'].toDouble(),
          posterPath: results['large_cover_image'],
          releaseDate: results['year'],
          genres: List<String>.from(results['genres']),
          overView: results['description_full'],
        );
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<List<Movie>> fetchMovies() async {
  var url = Uri.https(
    'yts.mx',
    'api/v2/list_movies.json',
  );

  final response = await http.get(url);
  final data = json.decode(response.body);
  final results = data['data']['movies'];
  List<Movie> movies = [];
  movies = results
      .map<Movie>((json) => Movie(
            id: json['id'],
            title: json['title'],
            voteAverage: json['rating'].toDouble(),
            posterPath: json['large_cover_image'],
            releaseDate: json['year'],
            genres: json['genres'],
            overView: json['description_full'],
          ))
      .toList();
  return movies;
}
