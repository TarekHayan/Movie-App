import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/UI/widgets/movies_categery.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/data/repos/movie_repo.dart';
import 'package:movie_app/data/web/movie_api.dart';
import 'package:movie_app/logic/cubit/cubit/get_movies_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = GetMoviesCubit(MovieRepo(movieApi: MovieApi()));
        cubit.getPopularMovies();
        cubit.getTopRatedMovies();
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
        title: RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'i', style: TextStyle(fontSize: 30)),
              TextSpan(
                text: 'F',
                style: TextStyle(
                  color: kPcolor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: 'ox', style: TextStyle(fontSize: 30)),
            ],
          ),
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
                  SizedBox(height: 30),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: kPcolor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Icon(Icons.house, color: Colors.white, size: 25),
                      ),
                      SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 30),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, color: Colors.white, size: 40),
              ),
              SizedBox(width: 25),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border_outlined, size: 40),
              ),
              SizedBox(width: 25),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
