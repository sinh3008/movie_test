import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_test/bloc/details_bloc/detail_movie_bloc.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailMovieBloc>().add(LoadMovieDetailEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        if (state is DetailMovieInitial) {
          return const Text('data');
        }
        if (state is DetailMovieLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DetailMovieSuccess) {
          return Scaffold(
            body: Center(
              child: Text(state.movie.title),
            ),
          );
        } else if (state is DetailMovieError) {
          return Text(state.error);
        }
        return const Text('nullll');
      },
    );
  }
}
