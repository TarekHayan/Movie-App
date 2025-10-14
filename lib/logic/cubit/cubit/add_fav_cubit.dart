import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/movie_model.dart';

part 'add_fav_state.dart';

class AddFavCubit extends Cubit<AddFavState> {
  AddFavCubit() : super(AddFavInitial());
  final List<MovieModel> _favorites = [];

  void toggleFavorite(MovieModel movie) {
    final exist = _favorites.any((m) => m.id == movie.id);

    if (exist) {
      _favorites.removeWhere((m) => m.id == movie.id);
    } else {
      _favorites.add(movie);
    }

    emit(FavoraitUpdate(movie: List.from(_favorites)));
  }

  bool isFavorite(MovieModel movie) {
    return _favorites.any((m) => m.id == movie.id);
  }
}
