import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/widgets/list_view_movies.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repos/movie_repo.dart';
import 'package:movie_app/data/web/movie_api.dart';
import 'package:movie_app/logic/cubit/cubit/get_movies_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // كل ما يفعله هذا الويدجت هو إنشاء الـ Cubit وتمريره للويدجت الذي يبني الواجهة
    return BlocProvider(
      create: (context) => GetMoviesCubit(MovieRepo(movieApi: MovieApi())),
      child:
          const _HomePageContent(), // <-- لاحظ أننا نستدعي الويدجت الثاني من هنا
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent> {
  late List<MovieModel> allMovies;
  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetMoviesCubit>();
    cubit.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'i', style: TextStyle(fontSize: 30)),
              TextSpan(
                text: 'N',
                style: TextStyle(
                  color: kPcolor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: 'ox', style: TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Popular", style: TextStyle(fontSize: 30)),
          ),
          SizedBox(height: 20),

          BlocBuilder<GetMoviesCubit, GetMoviesState>(
            builder: (context, state) {
              if (state is MoviesLoaded) {
                allMovies = state.movies;
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allMovies.length,
                    itemBuilder: (context, index) {
                      return ListViewMovies(movie: allMovies[index]);
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
