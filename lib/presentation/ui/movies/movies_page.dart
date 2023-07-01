import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_search/constants/event_manager.dart';
import 'package:movie_search/constants/string_constants.dart';
import 'package:movie_search/data/movies/repositories/movie_repository.dart';
import 'package:movie_search/di/injector.dart';
import 'package:movie_search/presentation/blocs/movies/events/movie_favorite_event.dart';
import 'package:movie_search/presentation/blocs/movies/movie_bloc.dart';
import 'package:movie_search/presentation/blocs/movies/movie_favorite_bloc.dart';
import 'package:movie_search/presentation/ui/movies/movie_favorite_widget.dart';
import 'package:movie_search/presentation/ui/movies/movies_search_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  StreamSubscription<ConnectivityResult>? _connectivityResultSubs;
  final _internetConnectionChecker = Injector.get<InternetConnectionChecker>();

  @override
  void initState() {
    _connectivityResultSubs =
        Connectivity().onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        var status = await _internetConnectionChecker.hasConnection;
        EventManager.setInternetActive(status);
      } else {
        EventManager.setInternetActive(false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _connectivityResultSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(StringConstants.titleMovieSearch)),
      ),
      body: RepositoryProvider(
        create: (context) => Injector.get<MovieRepository>(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: ((context) => Injector.get<MovieBloc>())),
            BlocProvider(
                create: ((context) => Injector.get<MovieFavoriteBloc>()
                  ..add(GetMovieFavorites()))),
          ],
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: const [
          MovieFavoriteWidget(),
          Expanded(child:  MoviesSearchWidget()),
        ],
      ),
    );
  }
}
