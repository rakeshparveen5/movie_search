import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/data/movies/models/movie_favorite.dart';
import 'package:movie_search/presentation/blocs/movies/movie_favorite_bloc.dart';
import 'package:movie_search/presentation/ui/movies/movie_detail.page.dart';
import 'package:movie_search/presentation/ui/widgets/label_chip.dart';

class MovieFavoriteListItem extends StatelessWidget {
  final MovieFavorite movieFavorite;

  const MovieFavoriteListItem({super.key, required this.movieFavorite});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: ListTile(
          title: Text(movieFavorite.name,
              overflow: TextOverflow.ellipsis,
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          subtitle: Text(
            "Runtime - ${movieFavorite.runtime}",
            overflow: TextOverflow.ellipsis,
          ),
          trailing: LabelChip(
              label: "Year - ${movieFavorite.year}",
              color: Theme.of(context).backgroundColor),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          dense: true,
          selected: true,
          selectedColor: Colors.blue,
          onTap: () =>
              _navigateToMovieDetailPage(context, movieFavorite.imdbID),
        ),
      ),
    );
  }

  _navigateToMovieDetailPage(BuildContext context, String imdbID) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<MovieFavoriteBloc>(context),
            child: MovieDetailPage(movieId: imdbID),
          ),
        ));
  }
}
