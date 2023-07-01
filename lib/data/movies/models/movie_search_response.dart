import 'package:movie_search/data/movies/models/movie.dart';

class MovieSearchResponse {
  static const kSearch = 'Search';
  static const kTotalResults = 'totalResults';
  static const kResponse = 'Response';

  final List<Movie> movieList;
  final String totalResults;
  final String response;

  MovieSearchResponse(this.movieList, this.totalResults, this.response);

  bool isSuccess() => response == 'True';

  factory MovieSearchResponse.fromJson(Map<String, dynamic> map) {
    var response = map[kResponse];

    List<Movie> movieSearchList = response == 'True'
        ? (map[kSearch] as List).map((e) => Movie.fromJson(e)).toList()
        : List.empty();

    return MovieSearchResponse(
      movieSearchList,
      map[kTotalResults] ?? '0',
      response,
    );
  }
}
