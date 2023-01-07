import 'package:get_storage/get_storage.dart';

final box = GetStorage('auth');

class Auth {
  static bool get isLoggedIn => box.hasData('sessionId');
  static bool get isGuestLoggedIn => box.hasData('guestSessionId');

  static String get getSessionId => box.read('sessionId');
  static String get getGuestSessionId => box.read('guestSessionId');

  static String? get getsessionExpireAt => box.read('expires_at');
  static String? get getUsername => box.read('username');
  static String? get getFullName => box.read('fullname');
  static String? get getAvatar => box.read('avatar');
  static String? get getGavatar => box.read('gavatar');

  static void setGusestSessionId(String sessionId) async =>
      await box.write("guestSessionId", sessionId);

  static void setSessionId(String sessionId) async =>
      await box.write("sessionId", sessionId);

  static void setExpiresAt(String expiresAt) async =>
      await box.write("expires_at", expiresAt);

  static void setUsername(String username) async =>
      await box.write("username", username);

  static void setFullname(String fullname) async =>
      await box.write("fullname", fullname);

  static void setUserAvatar(String avatar) async =>
      await box.write("avatar", avatar);

  static void setUserGrvatar(String avatar) async =>
      await box.write("gavatar", avatar);

  static void logOut() async => await box.erase();
}
