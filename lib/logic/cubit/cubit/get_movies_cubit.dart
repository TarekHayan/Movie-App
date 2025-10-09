import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/genre_movies_model.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repos/genre_movies_repo.dart';
import 'package:movie_app/data/repos/movie_repo.dart';

part 'get_movies_state.dart';

class GetMoviesCubit extends Cubit<GetMoviesState> {
  final MovieRepo movieRepo;
  final GenreMoviesRepo genreMoviesRepo;

  GetMoviesCubit(this.movieRepo, this.genreMoviesRepo) : super(MoviesInitial());

  List<MovieModel> popularMovies = [];
  List<MovieModel> topRatedMovies = [];
  List<MovieModel> nowPlayingMovies = [];
  List<GenreMoviesModel> geners = [];

  Future<void> getPopularMovies() async {
    try {
      emit(MoviesLoading());
      popularMovies = await movieRepo.getMovies(type: 'popular');
      emit(
        MoviesLoaded(
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          nowPlayingMovies: nowPlayingMovies,
          genres: geners,
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
          genres: geners,
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

      emit(
        MoviesLoaded(
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          nowPlayingMovies: nowPlayingMovies,
          genres: geners,
        ),
      );
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<void> getGenres() async {
    try {
      emit(MoviesLoading());
      geners = await genreMoviesRepo.getGeners();
      emit(
        MoviesLoaded(
          genres: geners,
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
