import '../models/trilar_movie_model.dart';
import '../web/trilar_movie_api.dart';

class TrilarMoviesRepo {
  final TrilarMovieApi trilarMovieApi;

  TrilarMoviesRepo({required this.trilarMovieApi});

  Future<List<TrilarMovieModel>> gettrilarMovies({required String name}) async {
    final trailers = await trilarMovieApi.getTrilarMovies(name: name);
    return trailers.map((trilar) => TrilarMovieModel.fromjson(trilar)).toList();
  }
}
