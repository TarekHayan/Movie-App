import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import '../widgets/list_view_fav_movie.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Please log in to view your favorites',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          // حالة التحميل
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          // حالة الخطأ
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'حدث خطأ أثناء تحميل المفضلة',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final favDocs = snapshot.data?.docs ?? [];

          // لو مفيش بيانات
          if (favDocs.isEmpty) {
            return const Center(
              child: Text(
                "No favorites yet",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          // عرض القائمة
          return ListView.builder(
            itemCount: favDocs.length,
            itemBuilder: (context, index) {
              final data = favDocs[index].data() as Map<String, dynamic>;
              return ListViewFavMovie(
                movie: MovieModel.fromJson(
                  data,
                ), // لو widget بتستقبل MovieModel، نعمل تحويل بسيط
              );
            },
          );
        },
      ),
    );
  }
}
