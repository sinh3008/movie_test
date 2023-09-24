import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_test/bloc/details_bloc/detail_movie_bloc.dart';
import 'package:movie_test/bloc/movies_bloc/movie_bloc.dart';
import 'package:movie_test/screen/popular/popular_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(),
        ),
        BlocProvider<DetailMovieBloc>(
          create: (context) => DetailMovieBloc(),
        )
      ],
      child: const MaterialApp(
        home: PopularListScreen(),
      ),
    );
  }
}
