import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/cubit/add_fav_cubit.dart';
import '../../data/models/movie_model.dart';

class AddToFav extends StatelessWidget {
  final MovieModel movie;
  const AddToFav({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFavCubit, AddFavState>(
      builder: (context, state) {
        bool isFav = false;
        if (state is FavoraitUpdate) {
          isFav = state.movie.any((m) => m.id == movie.id);
        }

        return IconButton(
          onPressed: () {
            context.read<AddFavCubit>().toggleFavorite(movie);
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              key: ValueKey<bool>(isFav),
              isFav ? Icons.favorite : Icons.favorite_border,
              size: 30,
              color: isFav ? Colors.red : Colors.white,
            ),
          ),
        );
      },
    );
  }
}
