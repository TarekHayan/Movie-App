import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repos/search_movie_repo.dart';

part 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  SearchMoviesCubit(this.searchMovieRepo) : super(SearchMoviesInitial());
  final SearchMovieRepo searchMovieRepo;
  List<MovieModel> searchMovies = [];

  Future<void> getSearchMovie({required String name}) async {
    try {
      emit(SearchMoviesLoading());
      searchMovies = await searchMovieRepo.getMovies(name: name);
      emit(SearchMoviesLoaded(searchMovies: searchMovies));
    } catch (e) {
      emit(SearchMoviesError(e.toString()));
    }
  }
}
