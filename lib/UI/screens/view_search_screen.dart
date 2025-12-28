import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_details_screen.dart';
import '../../constants/colors.dart';
import '../../logic/cubit/cubit/search_movies_cubit.dart';
import '../../helper/responsive_helper.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  @override
  void initState() {
    context.read<SearchMoviesCubit>().getSearchMovie(name: widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Results for "${widget.query}"',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
        builder: (context, state) {
          if (state is SearchMoviesLoading) {
            return Center(child: CircularProgressIndicator(color: kPcolor));
          }

          if (state is SearchMoviesLoaded) {
            final results = state.searchMovies;

            if (results.isEmpty) {
              return const Center(
                child: Text(
                  'No movies found',
                  style: TextStyle(color: Colors.white54, fontSize: 18),
                ),
              );
            }

            final crossAxisCount = ResponsiveHelper.getGridCrossAxisCount(context);
            final spacing = ResponsiveHelper.getGridSpacing(context);
            final padding = ResponsiveHelper.getResponsivePadding(context);
            final maxWidth = ResponsiveHelper.getMaxContentWidth(context);

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: GridView.builder(
                  padding: padding,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: ResponsiveHelper.getGridChildAspectRatio(context),
                  ),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                final movie = results[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GestureDetector(
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
                      color: const Color(0xFF1E1E1E),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              movie.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[800],
                                  child: const Icon(Icons.error, color: Colors.white),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              ResponsiveHelper.getResponsiveSpacing(
                                context,
                                mobile: 8,
                                tablet: 10,
                                desktop: 12,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ResponsiveHelper.getResponsiveFontSize(
                                      context,
                                      mobile: 12,
                                      tablet: 14,
                                      desktop: 16,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.getResponsiveSpacing(
                                    context,
                                    mobile: 4,
                                    tablet: 6,
                                    desktop: 8,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      movie.date,
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                                          context,
                                          mobile: 10,
                                          tablet: 12,
                                          desktop: 14,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: ResponsiveHelper.getResponsiveFontSize(
                                            context,
                                            mobile: 12,
                                            tablet: 14,
                                            desktop: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: ResponsiveHelper.getResponsiveSpacing(
                                            context,
                                            mobile: 3,
                                            tablet: 4,
                                            desktop: 5,
                                          ),
                                        ),
                                        Text(
                                          movie.rating.toStringAsFixed(1),
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                                              context,
                                              mobile: 10,
                                              tablet: 12,
                                              desktop: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
                ),
              ),
            );
          }

          if (state is SearchMoviesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            );
          }
          return const Center(
            child: Text(
              'Type something to search',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
