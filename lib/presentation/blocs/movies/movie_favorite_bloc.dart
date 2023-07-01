import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/data/movies/models/movie_favorite.dart';
import 'package:movie_search/data/movies/repositories/movie_repository.dart';
import 'package:movie_search/presentation/blocs/movies/events/movie_favorite_event.dart';
import 'package:movie_search/presentation/blocs/movies/states/movie_favorite_state.dart';

class MovieFavoriteBloc extends Bloc<MovieFavoriteEvent, MovieFavoriteState> {
  final MovieRepository movieRepository;

  MovieFavoriteBloc({required this.movieRepository})
      : super(MovieFavoriteLoading()) {
    on<GetMovieFavorites>(_mapGetMovieFavoriteEventToState);
  }

  FutureOr<void> _mapGetMovieFavoriteEventToState(
      GetMovieFavorites event, Emitter<MovieFavoriteState> emit) async {
    emit(MovieFavoriteLoading());
    try {
      var favoriteList = await movieRepository.getMovieFavoriteList();
      if (favoriteList.isNotEmpty) {
        emit(MovieFavoriteLoaded(moviesFavoriteList: favoriteList));
      } else {
        emit(const MovieFavoriteNoData());
      }
    } catch (error) {
      emit(MovieFavoriteError(errorMsg: error.toString()));
    }
  }

  Future<void> saveMovieFavorite(MovieFavorite movieFavorite) async {
    //save favorite data
    await movieRepository.saveMovieFavorite(movieFavorite);
    // get fresh favorite data
    add(GetMovieFavorites());
  }

  Future<void> deleteMovieFavorite(int id) async {
    //delete favorite data
    await movieRepository.deleteMovieFavorite(id);
    // get fresh favorite data
    add(GetMovieFavorites());
  }
}
