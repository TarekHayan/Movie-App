import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/web/categery_movie_api.dart';

class CategeryMovieRepo {
  final CategeryMovieApi movieCategeryApi;

  CategeryMovieRepo({required this.movieCategeryApi});

  Future<List<MovieModel>> getMoview({required int id}) async {
    final movies = await movieCategeryApi.getMoviesCategory(genreId: id);
    return movies.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
