part of 'detail_movie_bloc.dart';

abstract class DetailMovieState {}

class DetailMovieInitial extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieSuccess extends DetailMovieState {
  final Movie movie;

  DetailMovieSuccess(this.movie);
}

class DetailMovieError extends DetailMovieState {
  final String error;

  DetailMovieError({this.error = ''});
}
