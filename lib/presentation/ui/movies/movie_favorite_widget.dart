import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/constants/string_constants.dart';
import 'package:movie_search/data/movies/models/movie_favorite.dart';
import 'package:movie_search/presentation/blocs/movies/movie_favorite_bloc.dart';
import 'package:movie_search/presentation/blocs/movies/states/movie_favorite_state.dart';
import 'package:movie_search/presentation/ui/movies/movie_favorite_list_item.dart';
import 'package:movie_search/presentation/ui/widgets/loader_view.dart';
import 'package:movie_search/presentation/ui/widgets/message_view.dart';

class MovieFavoriteWidget extends StatelessWidget {
  const MovieFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Text(
            StringConstants.favorites,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        BlocBuilder<MovieFavoriteBloc, MovieFavoriteState>(
          builder: (context, state) {
            if (state is MovieFavoriteLoading) {
              return const LoaderView();
            } else if (state is MovieFavoriteError) {
              String message = state.errorMsg ?? 'Error in getting favorites!!';
              return MessageViewWidget(message: message);
            } else if (state is MovieFavoriteNoData) {
              return const MessageViewWidget(
                  message:
                      'No Favorites added yet.');
            } else if (state is MovieFavoriteLoaded) {
              List<MovieFavorite> favoriteList = state.moviesFavoriteList;
              return _buildMovieFavoriteListView(context, favoriteList);
            } else {
              return const MessageViewWidget(
                  message: 'No search results found.');
            }
          },
        ),
      ],
    );
  }

  Widget _buildMovieFavoriteListView(
      BuildContext context, List<MovieFavorite> favoriteList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
        itemCount: favoriteList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            MovieFavoriteListItem(movieFavorite: favoriteList[index]),
      ),
    );
  }
}
