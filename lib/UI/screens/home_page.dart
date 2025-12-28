import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_list_genere_movies.dart';
import '../widgets/movies_categery.dart';
import '../widgets/slide_show_movies.dart';
import '../../constants/colors.dart';
import '../../data/repos/genre_movies_repo.dart';
import '../../data/repos/movie_repo.dart';
import '../../data/web/genre_movies_api.dart';
import '../../data/web/movie_api.dart';
import '../../logic/cubit/cubit/get_movies_cubit.dart';
import '../../helper/responsive_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = GetMoviesCubit(
          MovieRepo(movieApi: MovieApi()),
          GenreMoviesRepo(genreMoviesApi: GenreMoviesApi()),
        );
        cubit.getPopularMovies();
        cubit.getTopRatedMovies();
        cubit.getNowPlayingMovies();
        cubit.getGenres();
        return cubit;
      },
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetMoviesCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Text("i", style: TextStyle(fontSize: 30)),
            Text(
              "F",
              style: TextStyle(
                color: kPcolor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const Text("ox", style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
      body: BlocBuilder<GetMoviesCubit, GetMoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading || state is MoviesInitial) {
            return Center(child: CircularProgressIndicator(color: kPcolor));
          } else if (state is MoviesLoaded) {
            final topSpacing = ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 20,
              tablet: 30,
              desktop: 40,
            );
            final sectionSpacing = ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 30,
              tablet: 40,
              desktop: 50,
            );
            final carouselHeight = ResponsiveHelper.getCarouselHeight(context);
            final maxWidth = ResponsiveHelper.getMaxContentWidth(context);

            return LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: topSpacing),
                          SizedBox(
                            height: carouselHeight,
                            child: SlideShowMovies(movies: state.nowPlayingMovies),
                          ),
                          SizedBox(height: sectionSpacing),
                          CustomListGenereMovies(geners: state.genres),
                          SizedBox(height: sectionSpacing),

                          MoviesCategery(
                            title: "Popular",
                            movies: state.popularMovies,
                            onloaded: cubit.getPopularMovies,
                          ),
                          SizedBox(height: sectionSpacing),
                          MoviesCategery(
                            title: "Top Rated",
                            movies: state.topRatedMovies,
                            onloaded: cubit.getTopRatedMovies,
                          ),
                          SizedBox(height: sectionSpacing),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is MoviesError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
