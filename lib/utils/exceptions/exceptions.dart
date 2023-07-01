import 'package:movie_search/constants/string_constants.dart';

class NetworkErrorException implements Exception {
  final String message;

  NetworkErrorException(this.message);

  @override
  String toString() => message;
}

class NetworkRequestFailedException implements Exception {
  final String message;

  NetworkRequestFailedException(this.message);

  @override
  String toString() => message;
}

class NoInternetException implements Exception {
  final String message;

  NoInternetException({this.message = StringConstants.errorMsgNoInternet});

  @override
  String toString() => message;
}
