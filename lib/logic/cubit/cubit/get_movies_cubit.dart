import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repos/movie_repo.dart';

part 'get_movies_state.dart';

class GetMoviesCubit extends Cubit<GetMoviesState> {
  MovieRepo movieRepo;
  GetMoviesCubit(this.movieRepo) : super(GetMoviesInitial());

  Future<void> getPopularMovies() async {
    try {
      emit(MoviesLoading()); // 1. البدء بحالة التحميل

      final List<MovieModel> movies = await movieRepo.getMovies(
        type: 'popular',
      );

      // 2. التحقق من عدد الأفلام (هذا السطر سيكشف المشكلة)
      print("تم تحليل ${movies.length} فيلم بنجاح.");

      emit(MoviesLoaded(movies: movies)); // 3. إرسال البيانات للواجهة
    } catch (e) {
      // 4. في حالة حدوث أي خطأ، سيتم طباعته هنا وإرسال حالة خطأ
      print("حدث خطأ أثناء جلب الأفلام: $e");
    }
  }
}
