import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/trilar_movie_model.dart';
import '../../../data/repos/trilar_movies_repo.dart';

part 'trilar_movies_state.dart';

class TrilarMoviesCubit extends Cubit<TrilarMoviesState> {
  final TrilarMoviesRepo trilarMoviesRepo;
  TrilarMoviesCubit(this.trilarMoviesRepo) : super(TrilarMoviesInitial());

  Future<void> getTrilarMovies({required String name}) async {
    emit(TrailerMoviesLoading());
    try {
      final trailers = await trilarMoviesRepo.gettrilarMovies(name: name);
      emit(TrailerMoviesSuccess(trailers));
    } catch (e) {
      emit(TrailerMoviesFailure(e.toString()));
    }
  }
}
