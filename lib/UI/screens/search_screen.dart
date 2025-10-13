import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/screens/view_search_screen.dart';
import 'package:movie_app/UI/widgets/custom_text_field.dart';
import 'package:movie_app/data/repos/search_movie_repo.dart';
import 'package:movie_app/data/web/search_movie_api.dart';
import 'package:movie_app/logic/cubit/cubit/search_movies_cubit.dart';
import 'package:movie_app/constants/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: controller,
              hintText: "Search for a movie...",
              onSubmitted: (value) {
                if (value.trim().isEmpty) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => SearchMoviesCubit(
                          SearchMovieRepo(SearchMovieApi()),
                        ),
                        child: SearchResultsScreen(query: value.trim()),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            const Icon(Icons.search, color: Colors.white54, size: 100),
            const SizedBox(height: 20),
            const Text(
              "Type something to search movies",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
