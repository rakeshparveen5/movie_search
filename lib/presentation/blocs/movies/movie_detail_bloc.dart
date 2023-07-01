import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/constants/event_manager.dart';
import 'package:movie_search/constants/string_constants.dart';
import 'package:movie_search/data/movies/repositories/movie_repository.dart';
import 'package:movie_search/presentation/blocs/movies/events/movie_event.dart';
import 'package:movie_search/presentation/blocs/movies/states/movie_state.dart';

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieDetailBloc({required this.movieRepository}) : super(MovieLoading()) {
    on<GetMovieDetails>(_mapGetMovieDetailEventToState);
  }

  FutureOr<void> _mapGetMovieDetailEventToState(
      GetMovieDetails event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      bool internetActive = EventManager.isInternetActive();
      if (!internetActive) {
        emit(const MovieError(errorMsg: StringConstants.errorMsgNoInternet));
      } else {
        final movieDetail = await movieRepository.getMovieDetail(event.id);
        emit(MovieDetailSuccess(movieDetail: movieDetail));
      }
    } catch (error) {
      emit(MovieError(errorMsg: error.toString()));
    }
  }
}
