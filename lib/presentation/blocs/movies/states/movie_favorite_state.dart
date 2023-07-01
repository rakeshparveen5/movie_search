import 'package:equatable/equatable.dart';
import 'package:movie_search/data/movies/models/movie_favorite.dart';

abstract class MovieFavoriteState extends Equatable {
  const MovieFavoriteState();
}

class MovieFavoriteLoading extends MovieFavoriteState {
  @override
  List<Object?> get props => [];
}

class MovieFavoriteError extends MovieFavoriteState {
  final String? errorMsg;

  const MovieFavoriteError({this.errorMsg});

  @override
  List<Object?> get props => [];
}

class MovieFavoriteNoData extends MovieFavoriteState {
  const MovieFavoriteNoData();

  @override
  List<Object?> get props => [];
}

class MovieFavoriteLoaded extends MovieFavoriteState {
  final List<MovieFavorite> moviesFavoriteList;

  const MovieFavoriteLoaded({required this.moviesFavoriteList});

  @override
  List<Object?> get props => [moviesFavoriteList];
}
