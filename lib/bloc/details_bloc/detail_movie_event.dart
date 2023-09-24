part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent {}
class LoadMovieDetailEvent extends DetailMovieEvent {
  final int idMovie;

  LoadMovieDetailEvent(this.idMovie);
}

