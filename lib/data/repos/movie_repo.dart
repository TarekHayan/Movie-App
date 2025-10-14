import '../models/movie_model.dart';
import '../web/movie_api.dart';

class MovieRepo {
  final MovieApi movieApi;

  MovieRepo({required this.movieApi});

  Future<List<MovieModel>> getMovies({required String type}) async {
    final movies = await movieApi.getMovies(type: type);
    print(movies);
    return movies.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
