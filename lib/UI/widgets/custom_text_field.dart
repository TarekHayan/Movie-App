import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onSubmitted,
    this.controller,
    this.hintText = 'Enter movie name...',
  });

  final Function(String) onSubmitted;
  final TextEditingController? controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      style: const TextStyle(color: Colors.white),
      cursorColor: kPcolor,
      textInputAction: TextInputAction.search, // 🔍 يخلي زر الكيبورد "Search"
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1C1C1C), // 🎨 خلفية غامقة خفيفة
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(Icons.search, color: kPcolor),
        ),
        labelText: 'Search for what?',
        labelStyle: const TextStyle(color: Colors.white70, fontSize: 14),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: kPcolor, width: 1.5),
        ),
      ),
    );
  }
}
