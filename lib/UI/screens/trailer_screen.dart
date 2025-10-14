import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic/cubit/cubit/trilar_movies_cubit.dart';
import 'package:movie_app/data/repos/trilar_movies_repo.dart';
import 'package:movie_app/data/web/trilar_movie_api.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailerScreen extends StatefulWidget {
  final int movieId;
  final String movieTitle;

  const TrailerScreen({
    super.key,
    required this.movieId,
    required this.movieTitle,
  });

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  YoutubePlayerController? _controller;

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = TrilarMoviesCubit(
          TrilarMoviesRepo(trilarMovieApi: TrilarMovieApi()),
        );
        cubit.getTrilarMovies(name: widget.movieId.toString());
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            '${widget.movieTitle} Trailer',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<TrilarMoviesCubit, TrilarMoviesState>(
          builder: (context, state) {
            if (state is TrailerMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.redAccent),
              );
            } else if (state is TrailerMoviesFailure) {
              return Center(
                child: Text(
                  'Error: ${state.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (state is TrailerMoviesSuccess) {
              if (state.trailers.isEmpty) {
                return const Center(
                  child: Text(
                    'No Trailer Found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final trailer = state.trailers.first;

              // أنشئ الـ controller مرة واحدة فقط
              _controller ??= YoutubePlayerController.fromVideoId(
                videoId: trailer.key,
                autoPlay: true,
                params: const YoutubePlayerParams(
                  showFullscreenButton: true,
                  enableCaption: false,
                ),
              );

              return Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(controller: _controller!),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
