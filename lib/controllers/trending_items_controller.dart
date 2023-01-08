import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/models/movies.dart';

import '../services/trending_items_service.dart';

class TrendingItemsController extends GetxController {
  final _trendingService = getIt<TrendingItemsService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var trendingMovies = <Movies>[].obs;

  int moviePage = 1;

  void getTrendingMovies({required String timeWindow, String? page})async{
    
  }
}
