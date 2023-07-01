import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_search/constants/string_constants.dart';
import 'package:movie_search/data/movies/repositories/movie_repository.dart';
import 'package:movie_search/data/movies/services/movie_local_service.dart';
import 'package:movie_search/data/movies/services/movie_remote_service.dart';
import 'package:movie_search/di/injector.dart';
import 'package:movie_search/helpers/db_helper.dart';
import 'package:movie_search/presentation/blocs/movies/movie_bloc.dart';
import 'package:movie_search/presentation/blocs/movies/movie_detail_bloc.dart';
import 'package:movie_search/presentation/blocs/movies/movie_favorite_bloc.dart';
import 'package:movie_search/presentation/ui/movies/movies_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes =
      1024 * 1024 * 300; // 300 MB
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  
  _registerDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      home: const MoviesPage(),
      theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.white,
          textTheme: const TextTheme()
              .apply(fontFamily: GoogleFonts.poppins().fontFamily)),
    );
  }
}

void _registerDependencies() {
  // third party packages dependencies
  Injector.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  Injector.registerLazySingleton<Dio>(() => Dio());

  // Helpers
  Injector.registerLazySingleton<DbHelper>(() => DbHelper());

  // Services
  Injector.registerLazySingleton<MovieLocalService>(
      () => MovieLocalServiceImpl(dbHelper: Injector.get()));
  Injector.registerLazySingleton<MovieRemoteService>(
      () => MovieRemoteServiceImpl(Injector.get()));

  // repositories
  Injector.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(Injector.get(), Injector.get()));

  // Blocs
  Injector.registerLazySingleton<MovieBloc>(
      () => MovieBloc(movieRepository: Injector.get<MovieRepository>()));
  Injector.registerLazySingleton<MovieFavoriteBloc>(() =>
      MovieFavoriteBloc(movieRepository: Injector.get<MovieRepository>()));
  Injector.registerFactory<MovieDetailBloc>(
      () => MovieDetailBloc(movieRepository: Injector.get<MovieRepository>()));
}
