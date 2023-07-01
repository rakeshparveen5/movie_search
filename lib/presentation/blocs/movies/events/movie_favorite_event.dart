import 'package:equatable/equatable.dart';

abstract class MovieFavoriteEvent extends Equatable {
  const MovieFavoriteEvent();
}

class GetMovieFavorites extends MovieFavoriteEvent {
  @override
  List<Object?> get props => [];
}
