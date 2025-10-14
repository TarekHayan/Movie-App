import 'package:dio/dio.dart';
import '../../constants/texts.dart';

class SearchMovieApi {
  final dio = Dio();

  Future<List<dynamic>> getSearchMovies({required String name}) async {
    try {
      Response response = await dio.get(
        '$kurlApi/search/movie',
        queryParameters: {
          'api_key': 'bb9fff2e4799cd1b17f50cea5c229876',
          'language': 'en-US',
          'region': 'US',
          'query': name,
        },
      );
      return response.data['results'];
    } catch (e) {
      print("error is  ${e.toString()}");
      return [];
    }
  }
}
