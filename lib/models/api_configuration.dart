class ApiConfiguration {
  final Images images;
  final List<String> changeKeys;

  ApiConfiguration({
    required this.images,
    required this.changeKeys,
  });

  factory ApiConfiguration.fromJson(Map<String, dynamic> json) =>
      ApiConfiguration(
          images: Images.fromJson(json["images"]),
          changeKeys: List<String>.from(json["change_keys"].map((e) => e)));

  Map<String, dynamic> toJson() => {
        "images": images.toJson(),
        "change_keys": List<dynamic>.from(changeKeys.map((e) => e)),
      };

  factory ApiConfiguration.initial() =>
      ApiConfiguration(images: Images.initial(), changeKeys: []);
}

class Images {
  final String baseUrl;
  final String secureBaseUrl;
  final List<String> backdropSizes;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final List<String> stillSizes;

  Images({
    required this.baseUrl,
    required this.secureBaseUrl,
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        baseUrl: json["base_url"],
        secureBaseUrl: json["secure_base_url"],
        backdropSizes: List<String>.from(json["backdrop_sizes"].map((e) => e)),
        logoSizes: List<String>.from(json["logo_sizes"].map((e) => e)),
        posterSizes: List<String>.from(json["poster_sizes"].map((e) => e)),
        profileSizes: List<String>.from(json["profile_sizes"].map((e) => e)),
        stillSizes: List<String>.from(json["still_sizes"].map((e) => e)),
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "secure_base_url": secureBaseUrl,
        "backdrop_sizes": List<dynamic>.from(backdropSizes.map((e) => e)),
        "logo_sizes": List<dynamic>.from(logoSizes.map((e) => e)),
        "poster_sizes": List<dynamic>.from(posterSizes.map((e) => e)),
        "profile_sizes": List<dynamic>.from(profileSizes.map((e) => e)),
        "still_sizes": List<dynamic>.from(stillSizes.map((e) => e)),
      };

  factory Images.initial() => Images(
        baseUrl: "",
        secureBaseUrl: "",
        backdropSizes: [],
        logoSizes: [],
        posterSizes: [],
        profileSizes: [],
        stillSizes: [],
      );
}
