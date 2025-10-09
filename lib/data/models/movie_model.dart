class MovieModel {
  final int id;
  final String langauge;
  final String decribtion;
  final String image;
  final String date;
  final String title;
  final double rating;

  MovieModel({
    required this.id,
    required this.langauge,
    required this.decribtion,
    required this.image,
    required this.date,
    required this.title,
    required this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      langauge: json['original_language'],
      decribtion: json['overview'],
      image: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      date: json['release_date'],
      title: json['title'],
      rating: json['vote_average'],
    );
  }
}
