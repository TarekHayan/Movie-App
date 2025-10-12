part of 'add_fav_cubit.dart';

@immutable
sealed class AddFavState {}

final class AddFavInitial extends AddFavState {}

final class FavoraitUpdate extends AddFavState {
  final List<MovieModel> movie;

  FavoraitUpdate({required this.movie});
}
