import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  static const kTitle = 'Title';
  static const kYear = 'Year';
  static const kImdbID = 'imdbID';
  static const kType = 'Type';
  static const kPoster = 'Poster';

  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  const Movie(
      {required this.title,
      required this.year,
      required this.imdbID,
      required this.type,
      required this.poster});

  @override
  List<Object?> get props => [title, year, imdbID, type, poster];

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      title: map[kTitle],
      year: map[kYear],
      imdbID: map[kImdbID],
      type: map[kType],
      poster: map[kPoster],
    );
  }
}
