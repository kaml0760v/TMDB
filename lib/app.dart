import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/app_config.dart';

import '_core/app_theme/app_theme.dart';
import '_core/init_bindings.dart';
import '_core/injection.dart';
import '_core/routes/app_routes.dart';
import '_core/routes/routes.dart';
import 'view/splash/splash_screen.dart';

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
        title: AppConfig.of(context)?.appTitle ?? "",
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}

Future appInitializer(AppConfig appConfig) async {
  await GetStorage.init('auth');

  configureInjection();

  final AppConfig configuredApp = AppConfig(
    appTitle: appConfig.appTitle,
    buildFlavor: appConfig.buildFlavor,
    envConfig: appConfig.envConfig,
    child: const MyApp(),
  );
  return runApp(configuredApp);
}
