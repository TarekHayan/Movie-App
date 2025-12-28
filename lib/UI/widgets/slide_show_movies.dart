import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../screens/movie_details_screen.dart';
import '../../data/models/movie_model.dart';
import '../../helper/responsive_helper.dart';

class SlideShowMovies extends StatelessWidget {
  const SlideShowMovies({super.key, required this.movies});
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    final height = ResponsiveHelper.getCarouselHeight(context);
    final viewportFraction = ResponsiveHelper.getCarouselViewportFraction(
      context,
    );

    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, scIndex) {
        final movie = movies[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                movie.image,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.error, color: Colors.white),
                  );
                },
              ),
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
        height: height,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: viewportFraction,
        autoPlayCurve: Curves.easeInOut,
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
