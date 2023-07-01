import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/data/movies/models/movie_detail.dart';
import 'package:movie_search/data/movies/models/movie_favorite.dart';
import 'package:movie_search/presentation/blocs/movies/movie_detail_bloc.dart';
import 'package:movie_search/presentation/blocs/movies/movie_favorite_bloc.dart';
import 'package:movie_search/presentation/blocs/movies/states/movie_favorite_state.dart';
import 'package:movie_search/presentation/blocs/movies/states/movie_state.dart';
import 'package:collection/collection.dart';

class MovieFavoriteFab extends StatelessWidget {
  const MovieFavoriteFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailBloc, MovieState>(
      listener: (context, state) {},
      builder: (context, detailState) {
        if (detailState is MovieDetailSuccess) {
          return BlocBuilder<MovieFavoriteBloc, MovieFavoriteState>(
            bloc: BlocProvider.of<MovieFavoriteBloc>(context),
            builder: (context, favState) {
              var movieDetail = detailState.movieDetail;

              if (favState is MovieFavoriteLoaded) {
                var imdbID = movieDetail.imdbID;
                var favList = favState.moviesFavoriteList;
                var movieFavorite = favList
                    .firstWhereOrNull((element) => element.imdbID == imdbID);
                var isFavorite = movieFavorite != null;

                return _buildFavoriteFab(
                    context, isFavorite, movieDetail, movieFavorite?.id);
              } else if (favState is MovieFavoriteNoData) {
                return _buildFavoriteFab(context, false, movieDetail, null);
              } else {
                return Container();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildFavoriteFab(BuildContext context, bool isFavorite,
      MovieDetail movieDetail, int? tableId) {
    return FloatingActionButton(
        backgroundColor: isFavorite ? Colors.green : Colors.red,
        child:
            Icon(isFavorite ? Icons.favorite : Icons.favorite_border_rounded),
        onPressed: () {
          MovieFavoriteBloc movieFavoriteBloc =
              BlocProvider.of<MovieFavoriteBloc>(context);

          if (isFavorite && tableId != null) {
            movieFavoriteBloc.deleteMovieFavorite(tableId);
          } else {
            MovieFavorite movieFavorite = MovieFavorite(
                imdbID: movieDetail.imdbID,
                name: movieDetail.title,
                year: movieDetail.year,
                runtime: movieDetail.runtime);
            movieFavoriteBloc.saveMovieFavorite(movieFavorite);
          }
        });
  }
}
