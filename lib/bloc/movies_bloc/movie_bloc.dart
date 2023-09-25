import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_test/repo/iNetworking.dart';

import '../../models/movie_model.dart';

import '../../repo/networking.dart';

part 'movie_event.dart';

part 'movie_state.dart';

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
    final iNetworking = NetWorking();
    movies = await iNetworking.fetchMovies();
    if (movies.isNotEmpty) {
      emit(MovieListSuccess(movies));
    } else {
      emit(MovieListError(error: 'error'));
    }
  }
}
