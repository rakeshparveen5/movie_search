import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/data/movies/models/movie.dart';
import 'package:movie_search/presentation/blocs/movies/movie_favorite_bloc.dart';
import 'package:movie_search/presentation/ui/movies/movie_detail.page.dart';
import 'package:movie_search/presentation/ui/widgets/label_chip.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  const MovieListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: _buildImage(movie.poster),
        title: Text(movie.title, style: textTheme.bodyMedium),
        subtitle: Text(movie.type, style: textTheme.bodySmall),
        trailing: LabelChip(
          label: "Year - ${movie.year}",
          color: Theme.of(context).backgroundColor,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        dense: true,
        selected: true,
        selectedColor: Colors.blue,
        onTap: () => _navigateToMovieDetailPage(context, movie.imdbID),
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

  Widget _buildImage(String poster) {
    return poster.startsWith('http')
        ? CachedNetworkImage(
            imageUrl: poster,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : const Icon(Icons.image, size: 38);
  }
}
