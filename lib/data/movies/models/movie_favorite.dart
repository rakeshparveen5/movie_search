import 'package:movie_search/constants/db_constants.dart';

class MovieFavorite {
  static const kImdbId = 'imdbID';
  static const kName = 'name';
  static const kYear = 'year';
  static const kRuntime = 'runtime';

  final int? id;
  final String imdbID;
  final String name;
  final String year;
  final String runtime;

  MovieFavorite({
    this.id,
    required this.imdbID,
    required this.name,
    required this.year,
    required this.runtime,
  });

  factory MovieFavorite.fromMap(Map<String, dynamic> map) {
    return MovieFavorite(
      id: map[DbConstants.columnId],
      imdbID: map[kImdbId],
      name: map[kName],
      year: map[kYear],
      runtime: map[kRuntime],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DbConstants.columnId: id,
      kImdbId: imdbID,
      kName: name,
      kYear: year,
      kRuntime: runtime,
    };
  }
}
