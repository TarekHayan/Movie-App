part of 'get_movies_cubit.dart';

abstract class GetMoviesState {}

class MoviesInitial extends GetMoviesState {}

class MoviesLoading extends GetMoviesState {}

class MoviesLoaded extends GetMoviesState {
  final List<MovieModel> popularMovies;
  final List<MovieModel> topRatedMovies;

  MoviesLoaded({required this.popularMovies, required this.topRatedMovies});
}

class MoviesError extends GetMoviesState {
  final String message;
  MoviesError(this.message);
}
