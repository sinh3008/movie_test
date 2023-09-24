part of 'movie_bloc.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieListLoading extends MovieState {}

class MovieListSuccess extends MovieState {
  final List<Movie> movies;

  MovieListSuccess(this.movies);
}

class MovieListError extends MovieState {
  final String error;

  MovieListError({this.error = ''});
}
