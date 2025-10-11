import 'package:flutter/material.dart';
import 'package:movie_app/UI/screens/welcom_screen.dart';
import 'package:movie_app/UI/widgets/buttom_navigator_bar.dart';

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
      initialRoute: "WelcomScreen",
      routes: {
        "WelcomScreen": (context) => WelcomScreen(),
        CustomBottomNav.id: (context) => CustomBottomNav(),
      },
    );
  }
}
