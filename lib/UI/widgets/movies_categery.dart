import 'package:flutter/material.dart';
import 'grid_view_movies.dart';
import 'list_view_movies.dart';
import '../../constants/colors.dart';
import '../../data/models/movie_model.dart';
import '../../helper/responsive_helper.dart';

class MoviesCategery extends StatefulWidget {
  const MoviesCategery({
    super.key,
    required this.title,
    required this.movies,
    required this.onloaded,
  });
  final String title;
  final List<MovieModel> movies;
  final VoidCallback onloaded;

  @override
  State<MoviesCategery> createState() => _MoviesCategeryState();
}

class _MoviesCategeryState extends State<MoviesCategery> {
  @override
  void initState() {
    super.initState();
    if (widget.movies.isEmpty) {
      widget.onloaded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveHelper.getResponsiveHorizontalPadding(context);
    final verticalSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 20,
      tablet: 24,
      desktop: 30,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 24,
      tablet: 28,
      desktop: 32,
    );
    final buttonFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 16,
      tablet: 18,
      desktop: 20,
    );
    final listHeight = ResponsiveHelper.getListItemHeight(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (contexr) {
                        return GridViewMovies(
                          itemCount: widget.movies.length,
                          movies: widget.movies,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'See all',
                  style: TextStyle(color: kPcolor, fontSize: buttonFontSize),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: verticalSpacing),
        widget.movies.isEmpty
            ? Center(child: CircularProgressIndicator(color: kPcolor))
            : SizedBox(
                height: listHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  itemCount: widget.movies.length,
                  itemBuilder: (context, index) {
                    return ListViewMovies(movie: widget.movies[index]);
                  },
                ),
              ),
      ],
    );
  }
}
