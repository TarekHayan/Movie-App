import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../screens/movie_details_screen.dart';
import '../../data/models/movie_model.dart';

class SlideShowMovies extends StatelessWidget {
  const SlideShowMovies({super.key, required this.movies});
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, scIndex) {
        final movie = movies[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(movie.image, fit: BoxFit.fill),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MovieDetailsScreen(movie: movie);
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.05),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        autoPlayCurve: Curves.easeInOut,
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
