import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view_search_screen.dart';
import '../widgets/custom_text_field.dart';
import '../../data/repos/search_movie_repo.dart';
import '../../data/web/search_movie_api.dart';
import '../../logic/cubit/cubit/search_movies_cubit.dart';
import '../../helper/responsive_helper.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final padding = ResponsiveHelper.getResponsivePadding(context);
          final maxWidth = ResponsiveHelper.getMaxContentWidth(context);
          final iconSize = ResponsiveHelper.getResponsiveFontSize(
            context,
            mobile: 80,
            tablet: 100,
            desktop: 120,
          );
          final textFontSize = ResponsiveHelper.getResponsiveFontSize(
            context,
            mobile: 14,
            tablet: 16,
            desktop: 18,
          );
          final spacing = ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 40,
            tablet: 50,
            desktop: 60,
          );

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: spacing),
                    Icon(Icons.search, color: Colors.white54, size: iconSize),
                    SizedBox(height: spacing / 2),
                    Text(
                      "Type something to search movies",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: textFontSize),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
