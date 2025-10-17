import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/UI/screens/auth.dart';
import 'package:movie_app/UI/screens/sign-Up_screen.dart';
import 'package:movie_app/constants/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static String id = 'SignInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailControlier = TextEditingController();
  final _passwordController = TextEditingController();
  Future sigin() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: _emailControlier.text.trim(),
          password: _passwordController.text.trim(),
        )
        .then((value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Auth()),
            (route) => false,
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _emailControlier.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcom Back Again :)',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kPcolor,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailControlier,
                  decoration: InputDecoration(
                    hint: const Text('Email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPcolor),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hint: const Text('Passoword'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPcolor),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kPcolor,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        await sigin();
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont have account ? ",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kPcolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
