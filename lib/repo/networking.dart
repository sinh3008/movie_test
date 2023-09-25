import 'package:movie_test/repo/iNetworking.dart';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetWorking extends INetworking {
  @override
  Future<Movie> fetchMovie(int idMovie) async {
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
          return Movie.fromJson(results);
        } else {
          throw Exception('Failed to load else1');
        }
      } else {
        throw Exception('Failed to load else 2');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load $e');
    }
  }

  @override
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
        .map<Movie>((json) => Movie.fromJson(json))
        .toList();
    return movies;
  }

  NetWorking();
}
