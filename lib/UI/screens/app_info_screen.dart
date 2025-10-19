import 'package:flutter/material.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});
  static String id = 'AppInfoScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('App Info', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About iFox',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'iFox is a movie application where you can explore and stay updated '
                'with the latest movies. You can browse trending films, view details, '
                'and add your favorite ones to a personalized favorites list.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Designed & Developed by',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              Text(
                'Tarek Hayan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Version 1.0.1',
                  style: TextStyle(color: Colors.white38, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
