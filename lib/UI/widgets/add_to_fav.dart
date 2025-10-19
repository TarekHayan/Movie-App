import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';

class AddToFav extends StatefulWidget {
  final MovieModel movie;
  const AddToFav({super.key, required this.movie});

  @override
  State<AddToFav> createState() => _AddToFavState();
}

class _AddToFavState extends State<AddToFav> {
  bool _isFav = false;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.movie.id.toString())
        .get();

    setState(() {
      _isFav = doc.exists;
    });
  }

  Future<void> _toggleFavorite() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final ref = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.movie.id.toString());

    if (_isFav) {
      // إزالة من المفضلة
      await ref.delete();
    } else {
      // إضافة للمفضلة
      await ref.set({
        'id': widget.movie.id,
        'title': widget.movie.title,
        'poster_path': widget.movie.image,
        'vote_average': widget.movie.rating,
      });
    }

    setState(() {
      _isFav = !_isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: Icon(
          key: ValueKey<bool>(_isFav),
          _isFav ? Icons.favorite : Icons.favorite_border,
          color: _isFav ? Colors.red : Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
