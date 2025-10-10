import 'package:dio/dio.dart';
import 'package:movie_app/constants/texts.dart';

class CategeryMovieApi {
  final dio = Dio();

  Future<List<dynamic>> getMoviesCategory({required int genreId}) async {
    try {
      final response = await dio.get(
        '$kurlApi/discover/movie',
        queryParameters: {
          'api_key': kapiKey,
          'language': 'en-US',
          'sort_by': 'popularity.desc',
          'with_genres': genreId,
          'with_origin_country': 'US',
        },
      );
      return response.data['results'];
    } catch (e) {
      print("Error in getMoviesByGenre: $e");
      return [];
    }
  }
}
