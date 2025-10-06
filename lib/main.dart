import 'package:flutter/material.dart';
import 'package:movie_app/UI/screens/home_page.dart';
import 'package:movie_app/data/repos/movie_repo.dart';
import 'package:movie_app/data/web/movie_api.dart';

void main() {
  runApp(MovieApp());
  MovieRepo(movieApi: MovieApi()).getMovies();
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: "HomePage",
      routes: {"HomePage": (context) => HomePage()},
    );
  }
}
