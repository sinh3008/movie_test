import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_test/screen/popular/body.dart';

class PopularListScreen extends StatefulWidget {
  const PopularListScreen({super.key});

  @override
  _PopularListScreenState createState() => _PopularListScreenState();
}

const apiKey = '26763d7bf2e94098192e629eb975dab0';
const page = '1';

class Movie {
  final String title;
  final double voteAverage;
  final String posterPath;
  final String releaseDate;

  Movie({
    required this.title,
    required this.voteAverage,
    required this.posterPath,
    required this.releaseDate,
  });
}

class _PopularListScreenState extends State<PopularListScreen> {
  List<Movie> movies = [];
  int currentPage = 1;
  List<Movie> allMovies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    var url = Uri.https(
      'api.themoviedb.org',
      '3/discover/movie',
      {
        'api_key': apiKey,
        'page': currentPage.toString(),
      },
    );

    final response = await http.get(url);
    final data = json.decode(response.body);
    final results = data['results'];

    setState(() {
      movies = results
          .map<Movie>((json) => Movie(
                title: json['title'],
                voteAverage: json['vote_average'].toDouble(),
                posterPath: json['poster_path'],
                releaseDate: json['release_date'],
              ))
          .toList();
      allMovies.addAll(movies);
    });
  }

  void loadMoreMovies() {
    currentPage++;
    fetchMovies();
  }

  Future<void> _refreshMovies() async {
    setState(() {
      allMovies.clear();
      currentPage = 1;
    });
    await fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: Colors.blue,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMovies,
        child: Body(allMovies: allMovies),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadMoreMovies();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
