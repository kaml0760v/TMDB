import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';

class InitBindings extends Bindings {
  InitBindings() {
    dependencies();
  }

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => UtilityController(), fenix: true);
  }
}
