import 'package:get_storage/get_storage.dart';

final box = GetStorage('auth');

class Auth {
  static bool get isLoggedIn => box.hasData('sessionId');
  static bool get isGuestLoggedIn => box.hasData('guestSessionId');

  static bool get sessionId => box.read('sessionId');
  static bool get guestSessionId => box.read('guestSessionId');
  
}
