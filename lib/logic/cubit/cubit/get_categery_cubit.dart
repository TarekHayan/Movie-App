import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/repos/categery_movie_repo.dart';

part 'get_categery_state.dart';

class GetCategeryCubit extends Cubit<GetCategeryState> {
  final CategeryMovieRepo categeryMovieRepo;
  final int id;

  GetCategeryCubit(this.categeryMovieRepo, this.id)
    : super(GetCategeryInitial());
  Future<void> getGategeryMovies() async {
    try {
      emit(CategeryMovieLoading());
      List<MovieModel> categeryMovie = await categeryMovieRepo.getMoview(
        id: id,
      );
      emit(CategeryMovieLoaded(getCategery: categeryMovie));
    } catch (e) {
      emit(CategeryMovieError(e.toString()));
    }
  }
}
