import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/services/configuration_service.dart';

import '../models/api_configuration.dart';

class ConfigurationController extends GetxController {
  final configurationService = getIt<ConfigurationService>();

  String _posterUrl = "";
  String _backDropUrl = "";
  String _profileUrl = "";
  String _logoUrl = "";
  String _stillUrl = "";

  String get posterUrl => _posterUrl;
  String get backDropUrl => _backDropUrl;
  String get profileUrl => _profileUrl;
  String get logoUrl => _logoUrl;
  String get stillUrl => _stillUrl;

  @override
  void onInit() {
    getConfigation();
    super.onInit();
  }

  var configuration = ApiConfiguration.initial().obs;

  void getConfigation() async {
    final result = await configurationService.getConfigation();

    result.fold(
      (l) => null,
      (r) {
        configuration.value =
            ApiConfiguration.fromJson(r as Map<String, dynamic>);

        _posterUrl =
            '${configuration.value.images.secureBaseUrl}${configuration.value.images.posterSizes[3]}';
        _backDropUrl =
            '${configuration.value.images.secureBaseUrl}${configuration.value.images.backdropSizes[1]}';
        _profileUrl =
            '${configuration.value.images.secureBaseUrl}${configuration.value.images.profileSizes[2]}';
        _logoUrl =
            '${configuration.value.images.secureBaseUrl}${configuration.value.images.logoSizes[3]}';
        _stillUrl =
            '${configuration.value.images.secureBaseUrl}${configuration.value.images.stillSizes[3]}';
      },
    );
  }
}
