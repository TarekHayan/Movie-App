import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repos/movie_repo.dart';

part 'get_movies_state.dart';

class GetMoviesCubit extends Cubit<GetMoviesState> {
  final MovieRepo movieRepo;

  GetMoviesCubit(this.movieRepo) : super(MoviesInitial());

  List<MovieModel> popularMovies = [];
  List<MovieModel> topRatedMovies = [];
  List<MovieModel> nowPlayingMovies = [];

  Future<void> getPopularMovies() async {
    try {
      emit(MoviesLoading());
      popularMovies = await movieRepo.getMovies(type: 'popular');
      emit(
        MoviesLoaded(
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          nowPlayingMovies: nowPlayingMovies,
        ),
      );
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<void> getTopRatedMovies() async {
    try {
      emit(MoviesLoading());
      topRatedMovies = await movieRepo.getMovies(type: 'top_rated');
      emit(
        MoviesLoaded(
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          nowPlayingMovies: nowPlayingMovies,
        ),
      );
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<void> getNowPlayingMovies() async {
    try {
      emit(MoviesLoading());
      nowPlayingMovies = await movieRepo.getMovies(type: 'now_playing');
      print('Now playing movies loaded: ${nowPlayingMovies.length}');

      emit(
        MoviesLoaded(
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          nowPlayingMovies: nowPlayingMovies,
        ),
      );
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}
