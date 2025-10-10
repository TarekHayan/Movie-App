import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/widgets/list_view_movies.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/logic/cubit/cubit/cubit/get_categery_cubit.dart';

class ShowGenereMovie extends StatelessWidget {
  const ShowGenereMovie({
    super.key,
    required this.generName,
    required this.nid,
    required this.lenght,
  });
  static String id = 'ShowGenereMovie';
  final String generName;
  final int nid;
  final int lenght;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetCategeryCubit, GetCategeryState>(
        builder: (context, state) {
          if (state is CategeryMovieLoaded) {
            return GridView.builder(
              itemCount: lenght,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 5,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (context, index) {
                return ListViewMovies(movie: state.getCategery[index]);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator(color: kPcolor));
          }
        },
      ),
    );
  }
}
