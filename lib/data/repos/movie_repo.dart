import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/web/movie_api.dart';

class MovieRepo {
  final MovieApi movieApi;

  MovieRepo({required this.movieApi});

  Future<List<MovieModel>> getMovies() async {
    final movies = await movieApi.getMovies(type: 'popular');
    print(movies);
    return movies.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
