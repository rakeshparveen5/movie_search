import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/constants/string_constants.dart';
import 'package:movie_search/data/movies/models/movie.dart';
import 'package:movie_search/extensions/string_extensions.dart';
import 'package:movie_search/helpers/toast_helper.dart';
import 'package:movie_search/presentation/blocs/movies/events/movie_event.dart';
import 'package:movie_search/presentation/blocs/movies/movie_bloc.dart';
import 'package:movie_search/presentation/blocs/movies/states/movie_state.dart';
import 'package:movie_search/presentation/ui/movies/movie_list_item.dart';
import 'package:movie_search/presentation/ui/widgets/loader_view.dart';
import 'package:movie_search/presentation/ui/widgets/message_view.dart';
import 'package:movie_search/presentation/ui/widgets/search_field.dart';

class MoviesSearchWidget extends StatelessWidget {
  const MoviesSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchField(
            tooltipText: StringConstants.titleMovieSearch,
            onSubmit: (query) => _onSubmitQuery(context, query)),
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieInitial) {
              return const MessageViewWidget(
                  message:
                      'Type the text in search field to search for the movies.');
            } else if (state is MovieLoading) {
              return const LoaderView();
            } else if (state is MovieError) {
              String message = state.errorMsg ?? 'Error in getting movies!!';
              return MessageViewWidget(message: message);
            } else if (state is MovieSearchSuccess) {
              List<Movie> moviesList = state.moviesList;
              return _buildMovieListView(moviesList);
            } else {
              return const MessageViewWidget(
                  message: 'No search results found.');
            }
          },
        ),
      ],
    );
  }

  void _onSubmitQuery(BuildContext context, String query) {
    if (query.isEmpty) {
      ToastHelper.showErrorToast(context, StringConstants.errFieldEmpty);
      return;
    } else if (query.isBlank()) {
      ToastHelper.showErrorToast(context, StringConstants.errFieldBlank);
      return;
    }

    context.read<MovieBloc>().add(SearchMovies(query: query));
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Widget _buildMovieListView(List<Movie> movieList) {
    return Expanded(
        child: ListView.separated(
            itemBuilder: (context, index) =>
                MovieListItem(movie: movieList[index]),
            separatorBuilder: (context, index) => const SizedBox(width: 25.0),
            itemCount: movieList.length));
  }
}
