import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/screens/welcom_screen.dart';
import 'package:movie_app/UI/widgets/buttom_navigator_bar.dart';
import 'package:movie_app/logic/cubit/cubit/add_fav_cubit.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFavCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        initialRoute: "WelcomScreen",
        routes: {
          "WelcomScreen": (context) => const WelcomScreen(),
          CustomBottomNav.id: (context) => const CustomBottomNav(),
        },
      ),
    );
  }
}
