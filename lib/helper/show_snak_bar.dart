import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';

void showSnackBar(BuildContext context, {required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white)),
      backgroundColor: kPcolor,
    ),
  );
}
