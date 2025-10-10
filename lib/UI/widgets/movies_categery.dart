import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/grid_view_movies.dart';
import 'package:movie_app/UI/widgets/list_view_movies.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/data/models/movie_model.dart';

class MoviesCategery extends StatefulWidget {
  const MoviesCategery({
    super.key,
    required this.title,
    required this.movies,
    required this.onloaded,
  });
  final String title;
  final List<MovieModel> movies;
  final VoidCallback onloaded;

  @override
  State<MoviesCategery> createState() => _MoviesCategeryState();
}

class _MoviesCategeryState extends State<MoviesCategery> {
  @override
  void initState() {
    super.initState();
    if (widget.movies.isEmpty) {
      widget.onloaded();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: TextStyle(fontSize: 30)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (contexr) {
                        return GridViewMovies(
                          itemCount: widget.movies.length,
                          movies: widget.movies,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'See all',
                  style: TextStyle(color: kPcolor, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        widget.movies.isEmpty
            ? Center(child: CircularProgressIndicator(color: kPcolor))
            : SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movies.length,
                  itemBuilder: (context, index) {
                    return ListViewMovies(movie: widget.movies[index]);
                  },
                ),
              ),
      ],
    );
  }
}
