import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/_core/routes/routes.dart';
import 'package:tmdp_getx_mvc/view/splash/splash_screen.dart';

import '_core/init_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init('auth');
  configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        initialRoute: AppRoutes.splashScreen,
        getPages: Routes.getRoutes(),
        initialBinding: InitBindings(),
        debugShowCheckedModeBanner: false,
        title: 'TMDB-D',
        theme: Apptheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
