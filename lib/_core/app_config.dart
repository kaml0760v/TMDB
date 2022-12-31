import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  static const String authApiKey = "078b386ba3506d3ee6ed0701e62bbefc";
  static const String baseUrl = "https://developers.themoviedb.org/3/";

  static const String readApiToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNzhiMzg2YmEzNTA2ZDNlZTZlZDA3MDFlNjJiYmVmYyIsInN1YiI6IjYzOGIwMTQzMGU2NGFmMDBhZGFhNTBmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Orto8EghZkt_IGTHiORTojY1hfJhkGzhWKYiv60_ipw";

  final String appTitle;
  final String buildFlavor;

  @override
  // ignore: overridden_fields
  final Widget child;
  final EnvConfig envConfig;

  const AppConfig({
    Key? key,
    required this.appTitle,
    required this.buildFlavor,
    required this.child,
    required this.envConfig,
  }) : super(child: child, key: key);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class EnvConfig {
  String apiBaseUrl;
  final String apiKey;
  final String readApiToken;

  EnvConfig({
    required this.apiBaseUrl,
    required this.apiKey,
    required this.readApiToken,
  });
}

var development = EnvConfig(
    apiBaseUrl: "https://developers.themoviedb.org/3/",
    apiKey: "078b386ba3506d3ee6ed0701e62bbefc",
    readApiToken:
        "eyJhdWQiOiIwNzhiMzg2YmEzNTA2ZDNlZTZlZDA3MDFlNjJiYmVmYyIsInN1YiI6IjYzOGIwMTQzMGU2NGFmMDBhZGFhNTBmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ");

var prod = EnvConfig(
    apiBaseUrl: "https://developers.themoviedb.org/3/",
    apiKey: "078b386ba3506d3ee6ed0701e62bbefc",
    readApiToken:
        "eyJhdWQiOiIwNzhiMzg2YmEzNTA2ZDNlZTZlZDA3MDFlNjJiYmVmYyIsInN1YiI6IjYzOGIwMTQzMGU2NGFmMDBhZGFhNTBmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ");
