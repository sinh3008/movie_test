part of 'movie_bloc.dart';

abstract class MovieEvent {}

class LoadMoviesEvent extends MovieEvent {}

class MoviesFetchedEvent extends MovieEvent {}
