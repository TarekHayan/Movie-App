import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/show_genere_movie.dart';
import '../../constants/colors.dart';
import '../../data/models/genre_movies_model.dart';
import '../../data/repos/categery_movie_repo.dart';
import '../../data/web/categery_movie_api.dart';
import '../../logic/cubit/cubit/get_categery_cubit.dart';
import '../../helper/responsive_helper.dart';

class CustomListGenereMovies extends StatelessWidget {
  const CustomListGenereMovies({super.key, required this.geners});
  final List<GenreMoviesModel> geners;

  @override
  Widget build(BuildContext context) {
    final height = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 40,
      tablet: 48,
      desktop: 56,
    );
    final horizontalPadding = ResponsiveHelper.getResponsiveHorizontalPadding(context);
    final margin = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 6,
      tablet: 8,
      desktop: 10,
    );
    final padding = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 10,
      tablet: 12,
      desktop: 16,
    );
    final fontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 14,
      tablet: 16,
      desktop: 18,
    );

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
              margin: EdgeInsets.symmetric(horizontal: margin),
              padding: EdgeInsets.symmetric(
                horizontal: padding * 1.6,
                vertical: padding,
              ),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
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
