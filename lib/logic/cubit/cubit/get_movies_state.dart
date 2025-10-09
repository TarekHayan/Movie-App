part of 'get_movies_cubit.dart';

abstract class GetMoviesState {}

class MoviesInitial extends GetMoviesState {}

class MoviesLoading extends GetMoviesState {}

class MoviesLoaded extends GetMoviesState {
  final List<MovieModel> popularMovies;
  final List<MovieModel> topRatedMovies;
  final List<MovieModel> nowPlayingMovies;
  final List<GenreMoviesModel> genres;

  MoviesLoaded({
    required this.genres,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.nowPlayingMovies,
  });
}

class MoviesError extends GetMoviesState {
  final String message;
  MoviesError(this.message);
}
