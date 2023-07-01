import 'package:equatable/equatable.dart';
import 'package:movie_search/data/movies/models/movie.dart';
import 'package:movie_search/data/movies/models/movie_detail.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieError extends MovieState {
  final String? errorMsg;

  const MovieError({this.errorMsg});

  @override
  List<Object?> get props => [];
}

// Movie Search - specific state
class MovieSearchSuccess extends MovieState {
  final List<Movie> moviesList;

  const MovieSearchSuccess({required this.moviesList});

  @override
  List<Object?> get props => [moviesList];
}

// Movie detail - specific state
class MovieDetailSuccess extends MovieState {
  final MovieDetail movieDetail;

  const MovieDetailSuccess({required this.movieDetail});

  @override
  List<Object?> get props => [movieDetail];
}
