part of 'get_categery_cubit.dart';

@immutable
sealed class GetCategeryState {}

final class GetCategeryInitial extends GetCategeryState {}

final class CategeryMovieLoading extends GetCategeryState {}

final class CategeryMovieLoaded extends GetCategeryState {
  final List<MovieModel> getCategery;

  CategeryMovieLoaded({required this.getCategery});
}

final class CategeryMovieError extends GetCategeryState {
  final String message;
  CategeryMovieError(this.message);
}
