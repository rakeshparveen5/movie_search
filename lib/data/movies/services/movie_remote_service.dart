import 'package:dio/dio.dart';
import 'package:movie_search/constants/api_constants.dart';
import 'package:movie_search/data/movies/models/movie_detail.dart';
import 'package:movie_search/data/movies/models/movie_search_response.dart';
import 'package:movie_search/utils/exceptions/exceptions.dart';

abstract class MovieRemoteService {
  Future<MovieSearchResponse> searchMovies(String query);
  Future<MovieDetail> getMovieDetail(String id);
}

class MovieRemoteServiceImpl extends MovieRemoteService {
  final Dio dio;

  MovieRemoteServiceImpl(this.dio);

  @override
  Future<MovieSearchResponse> searchMovies(String query) async {
    var queryParams = {'s': query};
    var response =
        await dio.get(ApiConstants.apiBaseUrl, queryParameters: queryParams);

    return response.statusCode == 200
        ? MovieSearchResponse.fromJson(response.data)
        : throw NetworkRequestFailedException(
            response.statusMessage ?? 'Unable to fetch the data!!');
  }

  @override
  Future<MovieDetail> getMovieDetail(String id) async {
    var queryParams = {'i': id};
    var response =
        await dio.get(ApiConstants.apiBaseUrl, queryParameters: queryParams);

    return response.statusCode == 200
        ? MovieDetail.fromJson(response.data)
        : throw NetworkRequestFailedException(
            response.statusMessage ?? 'Unable to fetch the data!!');
  }
}
