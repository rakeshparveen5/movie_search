import 'package:movie_search/data/movies/models/movie.dart';
import 'package:movie_search/data/movies/models/movie_detail.dart';
import 'package:movie_search/data/movies/models/movie_favorite.dart';
import 'package:movie_search/data/movies/models/movie_search_response.dart';
import 'package:movie_search/data/movies/services/movie_local_service.dart';
import 'package:movie_search/data/movies/services/movie_remote_service.dart';
import 'package:movie_search/utils/exceptions/exceptions.dart';

abstract class MovieRepository {
  Future<List<Movie>> searchMovies(String query);
  Future<MovieDetail> getMovieDetail(String id);

  Future<void> deleteMovieFavorite(int id);
  Future<List<MovieFavorite>> getMovieFavoriteList();
  Future<void> saveMovieFavorite(MovieFavorite movieFavorite);
  Future<void> updateMovieFavorite(MovieFavorite movieFavorite);
}

class MovieRepositoryImpl extends MovieRepository {
  final MovieLocalService _movieLocalService;
  final MovieRemoteService _movieRemoteService;

  MovieRepositoryImpl(this._movieLocalService, this._movieRemoteService);

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      MovieSearchResponse movieSearchResponse =
          await _movieRemoteService.searchMovies(query);
      if (movieSearchResponse.isSuccess()) {
        return movieSearchResponse.movieList;
      } else {
        throw NetworkErrorException('No item found!!');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieDetail> getMovieDetail(String id) async {
    try {
      MovieDetail movieDetail = await _movieRemoteService.getMovieDetail(id);
      if (movieDetail.isSuccess()) {
        return movieDetail;
      } else {
        throw NetworkErrorException('No item found!!');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteMovieFavorite(int id) async {
    return _movieLocalService.deleteMovieFavorite(id);
  }

  @override
  Future<List<MovieFavorite>> getMovieFavoriteList() async {
    return _movieLocalService.getMovieFavoriteList();
  }

  @override
  Future<void> saveMovieFavorite(MovieFavorite movieFavorite) async {
    return _movieLocalService.saveMovieFavorite(movieFavorite);
  }

  @override
  Future<void> updateMovieFavorite(MovieFavorite movieFavorite) async {
    return _movieLocalService.updateMovieFavorite(movieFavorite);
  }
}
