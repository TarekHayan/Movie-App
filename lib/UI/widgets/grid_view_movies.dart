import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/list_view_movies.dart';
import 'package:movie_app/data/models/movie_model.dart';

class GridViewMovies extends StatelessWidget {
  const GridViewMovies({
    super.key,
    required this.itemCount,
    required this.movies,
  });
  static String id = 'GridViewMovies';
  final int itemCount;
  final List<MovieModel> movies;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 5,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          return ListViewMovies(movie: movies[index]);
        },
      ),
    );
  }
}
