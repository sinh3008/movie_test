import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'detail_movie_event.dart';

part 'detail_movie_state.dart';

const apiKey = '26763d7bf2e94098192e629eb975dab0';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  late  Movie movie;

  DetailMovieBloc() : super(DetailMovieInitial()) {
    on<DetailMovieEvent>((event, emit) {});
    on<LoadMovieDetailEvent>(_loadMovie);
  }

  Future<Movie?> fetchMovie(int idMovie) async {
    try {
      var url = Uri.https(
        'yts.mx',
        'api/v2/movie_details.json',
        {
          'movie_id': idMovie.toString(),
        },
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['data']['movie'];

        if (results != null) {
          return Movie(
            id: results['id'],
            title: results['title'],
            voteAverage: results['rating'].toDouble(),
            posterPath: results['large_cover_image'],
            releaseDate: results['year'],
            genres: List<String>.from(results['genres']),
            overView: results['description_full'],
          );
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  FutureOr<void> _loadMovie(
    LoadMovieDetailEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    emit(DetailMovieLoading());

    movie = (await fetchMovie(event.idMovie))!;

    if (movie != null) {
      emit(DetailMovieSuccess(movie!));
    } else {
      emit(DetailMovieError(error: 'Failed to fetch movie details'));
    }
  }
}
