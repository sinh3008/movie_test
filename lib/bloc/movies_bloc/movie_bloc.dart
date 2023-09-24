import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'movie_event.dart';

part 'movie_state.dart';

const apiKey = '26763d7bf2e94098192e629eb975dab0';
const page = '1';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  List<Movie> movies = [];
  int currentPage = 1;

  MovieBloc() : super(MovieInitial()) {
    on<MovieEvent>((event, emit) {});
    on<MoviesFetchedEvent>(_loadMovies);
  }

  Future<List<Movie>> fetchMovies() async {
    var url = Uri.https(
      'yts.mx',
      'api/v2/list_movies.json',
    );

    final response = await http.get(url);
    final data = json.decode(response.body);
    final results = data['data']['movies'];

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

  FutureOr<void> _loadMovies(
      MoviesFetchedEvent event, Emitter<MovieState> emit) async {
    emit(MovieListLoading());
    await fetchMovies();
    if (movies.isNotEmpty) {
      emit(MovieListSuccess(movies));
    } else {
      emit(MovieListError(error: 'error'));
    }
  }
}
