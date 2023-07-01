import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable{
  static const kTitle = 'Title';
  static const kYear = 'Year';
  static const kRated = 'Rated';
  static const kReleased = 'Released';
  static const kRuntime = 'Runtime';
  static const kGenre = 'Genre';
  static const kDirector = 'Director';
  static const kWriter = 'Writer';
  static const kActors = 'Actors';
  static const kPlot = 'Plot';
  static const kLanguage = 'Language';
  static const kCountry = 'Country';
  static const kAwards = 'Awards';
  static const kPoster = 'Poster';
  static const kRatings = 'Ratings';
  static const kMetascore = 'Metascore';
  static const kImdbRating = 'imdbRating';
  static const kImdbVotes = 'imdbVotes';
  static const kImdbID = 'imdbID';
  static const kType = 'Type';
  static const kDvd = 'DVD';
  static const kBoxOffice = 'BoxOffice';
  static const kProduction = 'Production';
  static const kWebsite = 'Website';
  static const kResponse = 'Response';

  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final List<Ratings>? ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;
  final String response;

  const MovieDetail(
      {this.title = '',
      this.year = '',
      this.rated = '',
      this.released = '',
      this.runtime = '',
      this.genre = '',
      this.director = '',
      this.writer = '',
      this.actors = '',
      this.plot = '',
      this.language = '',
      this.country = '',
      this.awards = '',
      this.poster = '',
      this.ratings,
      this.metascore = '',
      this.imdbRating = '',
      this.imdbVotes = '',
      this.imdbID = '',
      this.type = '',
      this.dvd = '',
      this.boxOffice = '',
      this.production = '',
      this.website = '',
      required this.response});

  bool isSuccess() => response == 'True';

  factory MovieDetail.fromJson(Map<String, dynamic> map) {
    var response = map[kResponse];

    if (response != 'True') {
      return MovieDetail(response: response);
    }

    var ratings = map[kRatings];

    List<Ratings> ratingsList = ratings != null
        ? (ratings as List).map((e) => Ratings.fromJson(e)).toList()
        : List.empty();

    return MovieDetail(
      title: map[kTitle] ?? '',
      year: map[kYear] ?? '',
      rated: map[kRated] ?? '',
      released: map[kReleased] ?? '',
      runtime: map[kRuntime] ?? '',
      genre: map[kGenre] ?? '',
      director: map[kDirector] ?? '',
      writer: map[kWriter] ?? '',
      actors: map[kActors] ?? '',
      plot: map[kPlot] ?? '',
      language: map[kLanguage] ?? '',
      country: map[kCountry] ?? '',
      awards: map[kAwards] ?? '',
      poster: map[kPoster] ?? '',
      ratings: ratingsList,
      metascore: map[kMetascore] ?? '',
      imdbRating: map[kImdbRating] ?? '',
      imdbVotes: map[kImdbVotes] ?? '',
      imdbID: map[kImdbID] ?? '',
      type: map[kType] ?? '',
      dvd: map[kDvd] ?? '',
      boxOffice: map[kBoxOffice] ?? '',
      production: map[kProduction] ?? '',
      website: map[kWebsite] ?? '',
      response: map[kResponse],
    );
  }
  
  @override
  List<Object?> get props => [title,year,runtime,imdbRating,actors,plot];
}

class Ratings {
  static const kSource = 'Source';
  static const kValue = 'Value';

  String source;
  String value;

  Ratings({required this.source, required this.value});

  factory Ratings.fromJson(Map<String, dynamic> map) {
    return Ratings(
      source: map[kSource],
      value: map[kValue],
    );
  }
}
