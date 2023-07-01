import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/data/movies/models/movie_detail.dart';
import 'package:movie_search/presentation/blocs/movies/movie_detail_bloc.dart';
import 'package:movie_search/presentation/blocs/movies/states/movie_state.dart';
import 'package:movie_search/presentation/ui/movies/movie_favorite_fab.dart';
import 'package:movie_search/presentation/ui/widgets/label_chip.dart';
import 'package:movie_search/presentation/ui/widgets/loader_view.dart';
import 'package:movie_search/presentation/ui/widgets/message_view.dart';
import 'package:movie_search/presentation/ui/widgets/text_header.dart';

class MovieDetailWidget extends StatelessWidget {
  const MovieDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is MovieLoading) {
          return const LoaderView();
        } else if (state is MovieError) {
          String message = state.errorMsg ?? 'Error in getting movie detail!!';
          return MessageViewWidget(message: message);
        } else if (state is MovieDetailSuccess) {
          MovieDetail movieDetail = state.movieDetail;
          return _buildMovieDetailView(context, movieDetail);
        } else {
          return const MessageViewWidget(message: 'No results found.');
        }
      },
    );
  }

  Widget _buildMovieDetailView(BuildContext context, MovieDetail movieDetail) {
    return Stack(
      children: [
        Container(
          decoration: (movieDetail.poster.startsWith('http'))
              ? _getContainerBackground(movieDetail.poster)
              : null,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            children: [
              TextHeader(text: movieDetail.title),
              if (movieDetail.poster.startsWith('http')) ...{
                _buildPoster(context, movieDetail.poster),
              },
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  LabelChip(
                      label: "Year - ${movieDetail.year}",
                      color: Theme.of(context).backgroundColor),
                  LabelChip(
                      label: "Runtime - ${movieDetail.runtime}",
                      color: Theme.of(context).backgroundColor),
                  LabelChip(
                      label: "Rating - ${movieDetail.imdbRating}",
                      color: Theme.of(context).backgroundColor),
                ],
              ),
              ListTile(
                title: const Text('Artists :'),
                subtitle: TextHeader(text: movieDetail.actors),
              ),
              ListTile(
                title: const Text('Plot :'),
                subtitle: TextHeader(text: movieDetail.plot),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        const Positioned(
          bottom: 30,
          right: 30,
          child: MovieFavoriteFab(),
        )
      ],
    );
  }

  BoxDecoration _getContainerBackground(String poster) {
    return BoxDecoration(
      image: DecorationImage(
        colorFilter: ColorFilter.mode(Colors.grey.shade300, BlendMode.screen),
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(poster),
      ),
    );
  }

  Widget _buildPoster(BuildContext context, String poster) {
    return Padding(
        padding: const EdgeInsets.all(32),
        child: Container(
          padding: const EdgeInsets.only(bottom: 80),
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(poster),
              ),
              borderRadius: BorderRadius.circular(15)),
          height: MediaQuery.of(context).size.height / 2.7,
          width: MediaQuery.of(context).size.width / 4,
        ));
  }
}
