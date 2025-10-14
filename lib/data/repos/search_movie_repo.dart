import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/web/search_movie_api.dart';

class SearchMovieRepo {
  final SearchMovieApi searchMovieApi;

  SearchMovieRepo(this.searchMovieApi);

  Future<List<MovieModel>> getMovies({required String name}) async {
    final movies = await searchMovieApi.getSearchMovies(name: name);
    return movies.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
