import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/screens/app_info_screen.dart';
import 'package:movie_app/UI/screens/auth.dart';
import 'package:movie_app/UI/screens/sign-In_screen.dart';
import 'package:movie_app/UI/screens/sign-Up_screen.dart';
import 'package:movie_app/firebase_options.dart';
import 'UI/screens/welcom_screen.dart';
import 'UI/widgets/buttom_navigator_bar.dart';
import 'logic/cubit/cubit/add_fav_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        initialRoute: Auth.id,
        routes: {
          Auth.id: (context) => const Auth(),
          SignInScreen.id: (context) => const SignInScreen(),
          WelcomScreen.id: (context) => const WelcomScreen(),
          CustomBottomNav.id: (context) => const CustomBottomNav(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          AppInfoScreen.id: (context) => const AppInfoScreen(),
        },
      ),
    );
  }
}
