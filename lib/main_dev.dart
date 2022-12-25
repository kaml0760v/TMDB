import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/_core/routes/routes.dart';
import 'package:tmdp_getx_mvc/view/splash/splash_screen.dart';

void main() {
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
        debugShowCheckedModeBanner: false,
        title: 'TMDB-D',
        theme: ThemeData(
          fontFamily: 'Comfortaa',
          
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
