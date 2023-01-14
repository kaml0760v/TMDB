class Items {
  int? id;
  List<int>? genreIds;
  String? posterPath;
  bool? adult;
  String? overView;
  DateTime? releaseDate;
  String? originalLanguage;
  String? originalTitle;
  String? title;
  String? backdropPath;
  num? popularity;
  int? voteCount;
  bool? video;
  num? voteAverage;

  Items({
    this.id,
    this.adult,
    this.genreIds,
    this.overView,
    this.posterPath,
    this.releaseDate,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.popularity,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
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
        backdropPath: json['backdrop_path'] as String?,
        originalLanguage: json['original_language'] as String?,
        originalTitle: json['original_title'] as String?,
        popularity: json['popularity'] as num?,
        title: json['title'] as String?,
        video: json['video'] as bool?,
        voteAverage: json['vote_average'] as num?,
        voteCount: json['vote_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adult": adult,
        "genre_ids": genreIds,
        "overview": overView,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "backdrop_path": backdropPath,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "popularity": popularity,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
