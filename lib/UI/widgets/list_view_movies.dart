import 'package:flutter/material.dart';
import 'package:movie_app/constants/texts.dart';
import 'package:movie_app/data/models/movie_model.dart';

class ListViewMovies extends StatelessWidget {
  const ListViewMovies({super.key, required this.movie});
  final MovieModel movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(kImage + movie.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
