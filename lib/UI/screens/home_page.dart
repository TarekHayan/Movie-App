import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/widgets/custom_list_genere_movies.dart';
import 'package:movie_app/UI/widgets/movies_categery.dart';
import 'package:movie_app/UI/widgets/slide_show_movies.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/data/repos/genre_movies_repo.dart';
import 'package:movie_app/data/repos/movie_repo.dart';
import 'package:movie_app/data/web/genre_movies_api.dart';
import 'package:movie_app/data/web/movie_api.dart';
import 'package:movie_app/logic/cubit/cubit/get_movies_cubit.dart';

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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: SlideShowMovies(movies: state.nowPlayingMovies),
                  ),
                  const SizedBox(height: 50),
                  CustomListGenereMovies(geners: state.genres),
                  const SizedBox(height: 30),

                  MoviesCategery(
                    title: "Popular",
                    movies: state.popularMovies,
                    onloaded: cubit.getPopularMovies,
                  ),
                  const SizedBox(height: 30),
                  MoviesCategery(
                    title: "Top Rated",
                    movies: state.topRatedMovies,
                    onloaded: cubit.getTopRatedMovies,
                  ),
                ],
              ),
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
