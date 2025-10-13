part of 'search_movies_cubit.dart';

@immutable
sealed class SearchMoviesState {}

final class SearchMoviesInitial extends SearchMoviesState {}

final class SearchMoviesLoaded extends SearchMoviesState {
  final List<MovieModel> searchMovies;

  SearchMoviesLoaded({required this.searchMovies});
}

final class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesError extends SearchMoviesState {
  final String message;
  SearchMoviesError(this.message);
}
