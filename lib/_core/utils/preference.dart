import 'package:get_storage/get_storage.dart';

final prefs = GetStorage('prefs');

class Preferences {
  static void setMoveiIstodayState(bool data) =>
      prefs.write('movieIsToday', data);
  static void setTvIstodayState(bool data) => prefs.write('tvIsToday', data);

  static void setMovieNowPlayingState(bool data) =>
      prefs.write('isMovieNowPlaying', data);
  static void setTvAiringTodayState(bool data) =>
      prefs.write('isTvAiringToday', data);

  static bool get isMovieNowPlaying =>
      prefs.read('isMovieNowPlaying') ?? true;
  static bool get isTvAiringToday => prefs.read('isTvAiringToday') ?? true;

  static bool get movieIsToday => prefs.read('movieIsToday') ?? true;
  static bool get tvIsToday => prefs.read('tvIsToday') ?? true;
}
