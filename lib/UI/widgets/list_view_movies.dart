import 'package:flutter/material.dart';
import '../screens/movie_details_screen.dart';
import '../../data/models/movie_model.dart';
import '../../helper/responsive_helper.dart';

class ListViewMovies extends StatelessWidget {
  const ListViewMovies({super.key, required this.movie});
  final MovieModel movie;
  @override
  Widget build(BuildContext context) {
    final width = ResponsiveHelper.getListItemWidth(context);
    final height = ResponsiveHelper.getListItemHeight(context);
    final spacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 8,
      tablet: 12,
      desktop: 16,
    );

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
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: spacing),
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
