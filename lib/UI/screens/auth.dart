import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/UI/screens/home_page.dart';
import 'package:movie_app/UI/screens/sign-In_screen.dart';
import 'package:movie_app/UI/screens/welcom_screen.dart';
import 'package:movie_app/UI/widgets/buttom_navigator_bar.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});
  static String id = 'Auth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const CustomBottomNav();
          } else {
            return const WelcomScreen();
          }
        },
      ),
    );
  }
}
