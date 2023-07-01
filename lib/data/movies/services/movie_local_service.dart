import 'package:movie_search/constants/db_constants.dart';
import 'package:movie_search/data/movies/models/movie_favorite.dart';
import 'package:movie_search/helpers/db_helper.dart';

abstract class MovieLocalService {
  Future<void> deleteMovieFavorite(int id);
  Future<List<MovieFavorite>> getMovieFavoriteList();
  Future<void> saveMovieFavorite(MovieFavorite movieFavorite);
  Future<void> updateMovieFavorite(MovieFavorite movieFavorite);
}

class MovieLocalServiceImpl extends MovieLocalService {
  final DbHelper dbHelper;

  MovieLocalServiceImpl({required this.dbHelper});

  @override
  Future<void> deleteMovieFavorite(int id) async {
    await dbHelper.delete(
        table: DbConstants.tableMovieFavorite,
        whereColumn: DbConstants.columnId,
        whereValue: id);
  }

  @override
  Future<List<MovieFavorite>> getMovieFavoriteList() async {
    var list = await dbHelper.selectAll(table: DbConstants.tableMovieFavorite);
    return list.map((e) => MovieFavorite.fromMap(e)).toList();
  }

  @override
  Future<void> saveMovieFavorite(MovieFavorite movieFavorite) async {
    var row = movieFavorite.toMap();
    await dbHelper.insert(table: DbConstants.tableMovieFavorite, row: row);
  }

  @override
  Future<void> updateMovieFavorite(MovieFavorite movieFavorite) async {
    var row = movieFavorite.toMap();
    await dbHelper.update(
      table: DbConstants.tableMovieFavorite,
      whereColumn: DbConstants.columnId,
      whereValue: movieFavorite.id,
      row: row,
    );
  }
}
