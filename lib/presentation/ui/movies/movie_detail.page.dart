import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/constants/string_constants.dart';
import 'package:movie_search/di/injector.dart';
import 'package:movie_search/presentation/blocs/movies/events/movie_event.dart';
import 'package:movie_search/presentation/blocs/movies/movie_detail_bloc.dart';
import 'package:movie_search/presentation/ui/movies/movie_detail_widget.dart';

class MovieDetailPage extends StatelessWidget {
  final String movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(StringConstants.titleMovieDetail)),
      ),
      body: BlocProvider(
        create: (context) =>
            Injector.get<MovieDetailBloc>()..add(GetMovieDetails(id: movieId)),
        child: const MovieDetailWidget(),
      ),
    );
  }
}
