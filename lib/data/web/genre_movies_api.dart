import 'package:dio/dio.dart';
import '../../constants/texts.dart';

class GenreMoviesApi {
  final dio = Dio();

  Future<List<dynamic>> getGenre() async {
    try {
      Response response = await dio.get(
        '$kurlApi/genre/movie/list?api_key=bb9fff2e4799cd1b17f50cea5c229876&language=en',
      );
      return response.data['genres'];
    } catch (e) {
      print("error is  ${e.toString()}");
      return [];
    }
  }
}
