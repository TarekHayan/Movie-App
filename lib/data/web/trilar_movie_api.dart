import 'package:dio/dio.dart';
import '../../constants/texts.dart';

class TrilarMovieApi {
  final dio = Dio();

  Future<List<dynamic>> getTrilarMovies({required String name}) async {
    try {
      Response response = await dio.get(
        '$kurlApi/movie/$name/videos',
        queryParameters: {
          'api_key': 'bb9fff2e4799cd1b17f50cea5c229876',
          'language': 'en-US',
        },
      );
      final results = response.data['results'] as List;
      final trailers = results
          .where(
            (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
          )
          .toList();

      return trailers;
    } catch (e) {
      print("error is  ${e.toString()}");
      return [];
    }
  }
}
