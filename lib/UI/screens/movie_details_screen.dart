import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'trailer_screen.dart';
import '../widgets/add_to_fav.dart';
import '../../constants/colors.dart';
import '../../data/models/movie_model.dart';
import '../../data/repos/trilar_movies_repo.dart';
import '../../data/web/trilar_movie_api.dart';
import '../../logic/cubit/cubit/trilar_movies_cubit.dart';
import '../../helper/responsive_helper.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});
  final MovieModel movie;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TrilarMoviesCubit(TrilarMoviesRepo(trilarMovieApi: TrilarMovieApi())),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = ResponsiveHelper.isDesktop(context);
            final padding = ResponsiveHelper.getResponsivePadding(context);
            final maxWidth = ResponsiveHelper.getMaxContentWidth(context);
            final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
              context,
              mobile: 24,
              tablet: 28,
              desktop: 36,
            );
            final bodyFontSize = ResponsiveHelper.getResponsiveFontSize(
              context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            );
            final metaFontSize = ResponsiveHelper.getResponsiveFontSize(
              context,
              mobile: 18,
              tablet: 20,
              desktop: 22,
            );

            if (isDesktop) {
              // Desktop/Web layout: Side-by-side
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: padding,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image section
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: Image.network(
                                  movie.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[800],
                                      child: const Icon(Icons.error, color: Colors.white),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 32),
                          // Content section
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: kPcolor,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star, size: 24),
                                          const SizedBox(width: 8),
                                          Text(
                                            movie.rating.toStringAsFixed(1),
                                            style: TextStyle(fontSize: metaFontSize),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AddToFav(movie: movie),
                                  ],
                                ),
                                SizedBox(height: padding.vertical),
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: padding.vertical / 2),
                                Row(
                                  children: [
                                    Text(
                                      movie.date,
                                      style: TextStyle(fontSize: metaFontSize),
                                    ),
                                    Text(
                                      " - Language /  ",
                                      style: TextStyle(fontSize: metaFontSize),
                                    ),
                                    Text(
                                      movie.langauge.toUpperCase(),
                                      style: TextStyle(fontSize: metaFontSize),
                                    ),
                                  ],
                                ),
                                SizedBox(height: padding.vertical),
                                Text(
                                  movie.decribtion,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: bodyFontSize,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(height: padding.vertical),
                                SizedBox(
                                  width: double.infinity,
                                  child: BlocBuilder<TrilarMoviesCubit, TrilarMoviesState>(
                                    builder: (context, state) {
                                      return ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kPcolor,
                                          padding: EdgeInsets.symmetric(
                                            vertical: ResponsiveHelper.getTouchTargetSize(context) / 2,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return TrailerScreen(
                                                  movieId: movie.id,
                                                  movieTitle: movie.title,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          'Watch Trailer',
                                          style: TextStyle(
                                            fontSize: bodyFontSize,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // Mobile/Tablet layout: Stacked
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          movie.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 300,
                              color: Colors.grey[800],
                              child: const Icon(Icons.error, color: Colors.white),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          height: 300,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: Padding(
                        padding: padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: kPcolor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star, size: 20),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie.rating.toStringAsFixed(1),
                                        style: TextStyle(fontSize: metaFontSize),
                                      ),
                                    ],
                                  ),
                                ),
                                AddToFav(movie: movie),
                              ],
                            ),
                            SizedBox(height: padding.vertical),
                            Text(
                              movie.title,
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: padding.vertical / 2),
                            Row(
                              children: [
                                Text(
                                  movie.date,
                                  style: TextStyle(fontSize: metaFontSize),
                                ),
                                Text(
                                  " - Language /  ",
                                  style: TextStyle(fontSize: metaFontSize),
                                ),
                                Text(
                                  movie.langauge.toUpperCase(),
                                  style: TextStyle(fontSize: metaFontSize),
                                ),
                              ],
                            ),
                            SizedBox(height: padding.vertical),
                            Text(
                              movie.decribtion,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: bodyFontSize,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: padding.vertical),
                            SizedBox(
                              width: double.infinity,
                              child: BlocBuilder<TrilarMoviesCubit, TrilarMoviesState>(
                                builder: (context, state) {
                                  return ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPcolor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: ResponsiveHelper.getTouchTargetSize(context) / 2,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return TrailerScreen(
                                              movieId: movie.id,
                                              movieTitle: movie.title,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Watch Trailer',
                                      style: TextStyle(
                                        fontSize: bodyFontSize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
