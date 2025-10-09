class GenreMoviesModel {
  final int id;
  final String name;

  GenreMoviesModel({required this.id, required this.name});

  factory GenreMoviesModel.fromjson(Map<String, dynamic> json) {
    return GenreMoviesModel(id: json['id'], name: json['name']);
  }
}
