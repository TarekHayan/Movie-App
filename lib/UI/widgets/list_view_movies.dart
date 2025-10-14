import 'package:flutter/material.dart';
import '../screens/movie_details_screen.dart';
import '../../data/models/movie_model.dart';

class ListViewMovies extends StatelessWidget {
  const ListViewMovies({super.key, required this.movie});
  final MovieModel movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MovieDetailsScreen(movie: movie);
            },
          ),
        );
      },
      child: Container(
        width: 160,
        height: 240,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(movie.image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
