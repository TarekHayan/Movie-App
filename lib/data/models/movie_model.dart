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
    final rawPoster = json['poster_path']?.toString().trim();

    String imageUrl;
    if (rawPoster == null || rawPoster.isEmpty) {
      imageUrl =
          'https://jaybel.officechoice.com.au/Images/ProductImages/product-image-1.png';
    } else if (rawPoster.startsWith('http')) {
      imageUrl = rawPoster;
    } else {
      imageUrl = 'https://image.tmdb.org/t/p/w500$rawPoster';
    }

    return MovieModel(
      id: json['id'] ?? 0,
      langauge: json['original_language'] ?? '',
      decribtion: json['overview'] ?? '',
      image: imageUrl,
      date: json['release_date'] ?? '',
      title: json['title'] ?? '',
      rating: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
