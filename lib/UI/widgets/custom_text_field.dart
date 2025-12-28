import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../helper/responsive_helper.dart';

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
    final padding = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 16,
      tablet: 18,
      desktop: 20,
    );
    final fontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 14,
      tablet: 16,
      desktop: 18,
    );
    final labelFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 12,
      tablet: 14,
      desktop: 16,
    );
    final iconSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 20,
      tablet: 24,
      desktop: 28,
    );

    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      style: TextStyle(color: Colors.white, fontSize: fontSize),
      cursorColor: kPcolor,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1C1C1C),
        contentPadding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding * 1.125,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: padding * 0.625),
          child: Icon(Icons.search, color: kPcolor, size: iconSize),
        ),
        labelText: 'Search for what?',
        labelStyle: TextStyle(color: Colors.white70, fontSize: labelFontSize),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white38, fontSize: fontSize),
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
