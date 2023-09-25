import 'dart:async';

import 'package:bloc/bloc.dart';

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
    final NetWorking netWorking = NetWorking();
    movies = await netWorking.fetchMovies();
    if (movies.isNotEmpty) {
      emit(MovieListSuccess(movies));
    } else {
      emit(MovieListError(error: 'error'));
    }
  }
}
