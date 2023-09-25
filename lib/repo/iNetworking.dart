import '../models/movie_model.dart';

abstract class INetworking {
  Future<Movie?> fetchMovie(int idMovie);

  Future<List<Movie>> fetchMovies();
}
