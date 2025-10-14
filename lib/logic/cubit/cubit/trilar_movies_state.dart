part of 'trilar_movies_cubit.dart';

@immutable
sealed class TrilarMoviesState {}

final class TrilarMoviesInitial extends TrilarMoviesState {}

class TrailerMoviesLoading extends TrilarMoviesState {}

class TrailerMoviesSuccess extends TrilarMoviesState {
  final List<TrilarMovieModel> trailers;

  TrailerMoviesSuccess(this.trailers);
}

class TrailerMoviesFailure extends TrilarMoviesState {
  final String error;

  TrailerMoviesFailure(this.error);
}
