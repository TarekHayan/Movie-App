import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/movie_details_screen.dart';
import '../../constants/colors.dart';
import '../../data/models/movie_model.dart';
import '../../logic/cubit/cubit/add_fav_cubit.dart';
import '../../helper/responsive_helper.dart';

class ListViewFavMovie extends StatelessWidget {
  ListViewFavMovie({super.key, required this.movie});

  final String user = FirebaseAuth.instance.currentUser!.uid;

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final imageWidth = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 100,
      tablet: 120,
      desktop: 140,
    );
    final imageHeight = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 130,
      tablet: 160,
      desktop: 190,
    );
    final padding = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 12,
      tablet: 16,
      desktop: 20,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 16,
      tablet: 18,
      desktop: 20,
    );
    final ratingFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 12,
      tablet: 14,
      desktop: 16,
    );
    final iconSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      mobile: 16,
      tablet: 18,
      desktop: 20,
    );
    final bottomMargin = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: 16,
      tablet: 20,
      desktop: 24,
    );

    return GestureDetector(
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
        margin: EdgeInsets.only(bottom: bottomMargin),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: kPcolor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // صورة الفيلم
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.network(
                movie.image,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: imageWidth,
                    height: imageHeight,
                    color: Colors.grey[800],
                    child: const Icon(Icons.error, color: Colors.white),
                  );
                },
              ),
            ),

            // معلومات الفيلم
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: padding / 2),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: iconSize),
                        SizedBox(width: padding / 3),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: ratingFontSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // زرار إزالة من المفضلة
            IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                color: kPcolor,
                size: ResponsiveHelper.getTouchTargetSize(context),
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(user)
                    .collection("favorites")
                    .doc(movie.id.toString())
                    .delete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
