import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UtitlityController extends GetxController {

  Future<void> loadUrl({required String uri}) async {
    final Uri url = Uri.parse(uri);

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
    return;
  }
}
