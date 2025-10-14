class TrilarMovieModel {
  final String name;
  final String key;
  final String site;
  final String type;

  TrilarMovieModel({
    required this.name,
    required this.key,
    required this.site,
    required this.type,
  });
  factory TrilarMovieModel.fromjson(Map<String, dynamic> json) {
    return TrilarMovieModel(
      name: json['name'],
      key: json['key'],
      site: json['site'],
      type: json['type'],
    );
  }
}
