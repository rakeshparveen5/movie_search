import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

// Search Movies
class SearchMovies extends MovieEvent {
  final String query;

  const SearchMovies({required this.query});

  @override
  List<Object?> get props => [query];
}

// Get Movie detail
class GetMovieDetails extends MovieEvent {
  final String id;
  const GetMovieDetails({required this.id});

  @override
  List<Object> get props => [id];
}
