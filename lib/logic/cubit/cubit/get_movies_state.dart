part of 'get_movies_cubit.dart';

@immutable
sealed class GetMoviesState {}

final class GetMoviesInitial extends GetMoviesState {}

final class MoviesLoaded extends GetMoviesState {
  final List<MovieModel> movies;

  MoviesLoaded({required this.movies});
}

final class MoviesLoading extends GetMoviesState {}
