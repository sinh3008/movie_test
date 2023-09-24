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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie'),
        centerTitle: true,
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
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  if (index < state.movies.length) {
                    final movie = state.movies[index];
                    if (movie.voteAverage == 0.0) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2, // Phạm vi đổ bóng
                              blurRadius: 5, // Độ mờ của đổ bóng
                              offset: const Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(
                              movie.posterPath,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        margin: const EdgeInsets.all(14),
                        child: const Center(child: Text('Error')),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        BlocListener<DetailMovieBloc, DetailMovieState>(
                          listener: (context, state) {
                            context
                                .read<DetailMovieBloc>()
                                .add(LoadMovieDetailEvent(movie.id));
                          },
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsScreen(id: state.movies[index].id);
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
