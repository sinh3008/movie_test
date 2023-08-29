import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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
        'page': page,
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 6, top: 6),
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      child: Center(
                        child: Text(
                          '${movie.voteAverage.toDouble()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.releaseDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
