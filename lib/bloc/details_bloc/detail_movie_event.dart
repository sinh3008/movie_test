part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent {}

class LoadMovieDetailEvent extends DetailMovieEvent {
  final Movie movie;

  LoadMovieDetailEvent(this.movie);
}
