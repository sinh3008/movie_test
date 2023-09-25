import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/movie_model.dart';
import '../../repo/networking.dart';

part 'detail_movie_event.dart';

part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  late Movie? movie;

  DetailMovieBloc() : super(DetailMovieInitial()) {
    on<DetailMovieEvent>((event, emit) {});
    on<LoadMovieDetailEvent>(_loadMovie);
  }

  FutureOr<void> _loadMovie(
    LoadMovieDetailEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    final netWorking = NetWorking();
    emit(DetailMovieLoading());
    movie = await netWorking.fetchMovie(event.idMovie);
    if (movie != null) {
      emit(DetailMovieSuccess(movie!));
    } else {
      emit(DetailMovieError(error: 'Failed to fetch movie details'));
    }
  }
}
