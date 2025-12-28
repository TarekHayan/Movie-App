import 'package:flutter/material.dart';
import 'list_view_movies.dart';
import '../../data/models/movie_model.dart';
import '../../helper/responsive_helper.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = ResponsiveHelper.getGridCrossAxisCount(context);
          final spacing = ResponsiveHelper.getGridSpacing(context);
          final aspectRatio = ResponsiveHelper.getGridChildAspectRatio(context);
          final padding = ResponsiveHelper.getResponsiveHorizontalPadding(context);

          return GridView.builder(
            padding: EdgeInsets.all(padding),
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              childAspectRatio: aspectRatio,
            ),
            itemBuilder: (context, index) {
              return ListViewMovies(movie: movies[index]);
            },
          );
        },
      ),
    );
  }
}
