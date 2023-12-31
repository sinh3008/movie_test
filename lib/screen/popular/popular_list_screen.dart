import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_test/bloc/details_bloc/detail_movie_bloc.dart';
import 'package:movie_test/models/movie_model.dart';
import 'package:movie_test/screen/details/details_screen.dart';
import 'package:movie_test/screen/popular/widgets/body.dart';

import '../../bloc/movies_bloc/movie_bloc.dart';

class PopularListScreen extends StatefulWidget {
  const PopularListScreen({super.key});

  @override
  State<PopularListScreen> createState() => _PopularListScreenState();
}

class _PopularListScreenState extends State<PopularListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MoviesFetchedEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    bool switchValue = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Switch(
              value: switchValue,
              onChanged: (newValue) {
                setState(() {
                  switchValue = newValue;
                });
              })
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieListSuccess) {
              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  if (index < state.movies.length) {
                    final movie = state.movies[index];
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<DetailMovieBloc>()
                            .add(LoadMovieDetailEvent(movie.id));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsScreen(
                                idMovie: movie.id,
                              );
                            },
                          ),
                        );
                      },
                      child: Body(
                        movie: movie,
                      ),
                    );
                  }
                },
              );
            } else {
              return Center(
                child: Text(state.toString()),
              );
            }
          },
        ),
      ),
    );
  }
}
