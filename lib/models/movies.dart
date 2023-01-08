class Movies {
  int? id;
  List<int>? genreIds;
  String? posterPath;
  bool? adult;
  String? overView;
  DateTime? releaseDate;

  Movies({
    this.id,
    this.adult,
    this.genreIds,
    this.overView,
    this.posterPath,
    this.releaseDate,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        id: json["id"] as int?,
        adult: json['adult'] as bool?,
        genreIds: (json['genre_ids'] as List<dynamic>?)
            ?.map((e) => e as int)
            .toList(),
        overView: json['overview'] as String?,
        posterPath: json['poster_path'] as String?,
        releaseDate: ((json['release_date'] ?? "") as String).isEmpty
            ? null
            : DateTime.parse(json['release_date'] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adult": adult,
        "genre_ids": genreIds,
        "overview": overView,
        "poster_path": posterPath,
        "release_date": releaseDate,
      };
}
