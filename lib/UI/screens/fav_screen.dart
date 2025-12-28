import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import '../widgets/list_view_fav_movie.dart';
import '../../helper/responsive_helper.dart';
import 'movie_details_screen.dart';

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
          final isDesktop = ResponsiveHelper.isDesktop(context);
          final padding = ResponsiveHelper.getResponsivePadding(context);
          final maxWidth = ResponsiveHelper.getMaxContentWidth(context);

          if (isDesktop) {
            // Desktop: Use GridView
            final crossAxisCount = ResponsiveHelper.getGridCrossAxisCount(context);
            final spacing = ResponsiveHelper.getGridSpacing(context);

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: GridView.builder(
                  padding: padding,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: spacing,
                    crossAxisSpacing: spacing,
                    childAspectRatio: ResponsiveHelper.getGridChildAspectRatio(context),
                  ),
                  itemCount: favDocs.length,
                  itemBuilder: (context, index) {
                    final data = favDocs[index].data() as Map<String, dynamic>;
                    final movie = MovieModel.fromJson(data);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsScreen(movie: movie),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          movie.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(Icons.error, color: Colors.white),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            // Mobile/Tablet: Use ListView
            return ListView.builder(
              padding: padding,
              itemCount: favDocs.length,
              itemBuilder: (context, index) {
                final data = favDocs[index].data() as Map<String, dynamic>;
                return ListViewFavMovie(
                  movie: MovieModel.fromJson(data),
                );
              },
            );
          }
        },
      ),
    );
  }
}
