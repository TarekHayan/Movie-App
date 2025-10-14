import 'package:movie_app/data/models/genre_movies_model.dart';
import 'package:movie_app/data/web/genre_movies_api.dart';

class GenreMoviesRepo {
  final GenreMoviesApi genreMoviesApi;

  GenreMoviesRepo({required this.genreMoviesApi});

  Future<List<GenreMoviesModel>> getGeners() async {
    final geners = await genreMoviesApi.getGenre();
    return geners.map((gener) => GenreMoviesModel.fromjson(gener)).toList();
  }
}
