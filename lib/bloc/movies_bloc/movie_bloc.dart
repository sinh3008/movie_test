import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../repo/networking.dart';

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

  FutureOr<void> _loadMovies(
      MoviesFetchedEvent event, Emitter<MovieState> emit) async {
    emit(MovieListLoading());
    movies = await fetchMovies();
    if (movies.isNotEmpty) {
      emit(MovieListSuccess(movies));
    } else {
      emit(MovieListError(error: 'error'));
    }
  }
}
