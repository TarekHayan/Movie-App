import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/screens/movie_details_screen.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/logic/cubit/cubit/search_movies_cubit.dart';

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

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عدد الأعمدة
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65, // شكل الصورة
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
                          Image.network(
                            movie.image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      movie.date,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          movie.rating.toStringAsFixed(1),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
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
