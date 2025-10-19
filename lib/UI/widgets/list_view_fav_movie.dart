import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/movie_details_screen.dart';
import '../../constants/colors.dart';
import '../../data/models/movie_model.dart';
import '../../logic/cubit/cubit/add_fav_cubit.dart';

class ListViewFavMovie extends StatelessWidget {
  ListViewFavMovie({super.key, required this.movie});

  final String user = FirebaseAuth.instance.currentUser!.uid;

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
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
        margin: const EdgeInsets.only(bottom: 20),
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
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),

            // معلومات الفيلم
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
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
                size: 30,
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
