import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/list_view_fav_movie.dart';
import '../../logic/cubit/cubit/add_fav_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<AddFavCubit, AddFavState>(
        builder: (context, state) {
          if (state is FavoraitUpdate) {
            if (state.movie.isEmpty) {
              return const Center(
                child: Text(
                  "No favorites yet",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.movie.length,
              itemBuilder: (context, index) {
                final movie = state.movie[index];
                return ListViewFavMovie(movie: movie);
              },
            );
          }
          return const Center(
            child: Text(
              "No favorites yet",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
