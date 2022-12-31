import 'package:flutter/material.dart';
import 'package:tmdp_getx_mvc/_core/app_config.dart';
import 'package:tmdp_getx_mvc/_core/app_constant.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  envConfig = development;
  final appConfig = AppConfig(
      appTitle: "TMDB Dev",
      buildFlavor: "dev",
      envConfig: development,
      child: Container(),);

  await appInitializer(appConfig);
}

