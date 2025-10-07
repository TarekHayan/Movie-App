import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:movie_app/UI/screens/home_page.dart';
import 'package:movie_app/data/repos/movie_repo.dart';
import 'package:movie_app/data/web/movie_api.dart';
import 'package:movie_app/logic/cubit/cubit/get_movies_cubit.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: "HomePage",
      routes: {"HomePage": (context) => HomePage()},
    );
  }
}
