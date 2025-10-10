import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/screens/show_genere_movie.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/data/models/genre_movies_model.dart';
import 'package:movie_app/data/repos/categery_movie_repo.dart';
import 'package:movie_app/data/web/categery_movie_api.dart';
import 'package:movie_app/logic/cubit/cubit/cubit/get_categery_cubit.dart';

class CustomListGenereMovies extends StatelessWidget {
  const CustomListGenereMovies({super.key, required this.geners});
  final List<GenreMoviesModel> geners;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: geners.length,
        itemBuilder: (context, index) {
          final genre = geners[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) {
                        final cubit = GetCategeryCubit(
                          CategeryMovieRepo(
                            movieCategeryApi: CategeryMovieApi(),
                          ),
                          genre.id,
                        );
                        cubit.getGategeryMovies();
                        return cubit;
                      },
                      child: ShowGenereMovie(
                        generName: genre.name,
                        nid: genre.id,
                        lenght: geners.length,
                      ),
                    );
                  },
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPcolor, const Color(0xFF1E1E1E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  genre.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
