import 'package:dio/dio.dart';
import 'package:movie_app/constants/texts.dart';

class MovieApi {
  final dio = Dio();

  Future<List<dynamic>> getMovies({required String type}) async {
    try {
      Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/$type?api_key=$kapiKey&language=en-US&page=1',
      );
      return response.data['results'];
    } catch (e) {
      print("error is  ${e.toString()}");
      return [];
    }
  }
}
