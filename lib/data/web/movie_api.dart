import 'package:dio/dio.dart';

class MovieApi {
  final dio = Dio();

  Future<List<dynamic>> getMovies({required String type}) async {
    try {
      Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/$type',
        queryParameters: {
          'api_key': 'bb9fff2e4799cd1b17f50cea5c229876',
          'language': 'en-US',
          'region': 'US',
        },
      );
      return response.data['results'];
    } catch (e) {
      print("error is  ${e.toString()}");
      return [];
    }
  }
}
