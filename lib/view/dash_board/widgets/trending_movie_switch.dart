import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/controllers/trending_items_controller.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/widgets/loader_dialog.dart';

class TrendingMovieSwitchBtnBuilder extends StatelessWidget {
  TrendingMovieSwitchBtnBuilder({
    this.color,
    this.selectedColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.border,
    Key? key,
  }) : super(key: key);

  final Color? color;
  final Color? selectedColor;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;

  final _utilityController = Get.find<UtilityController>();
  final _trendingItemController = Get.find<TrendingItemsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: color ?? AppTheme.primaryColor,
          border: border,
        ),
        child: Row(
          children: [
            _trendingItemController.isMovieFetching.value
                ? Container(
                    height: 20,
                    padding: padding ??
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: LoadingSpinner().horizontalLoading,
                  )
                : GestureDetector(
                    onTap: () {
                      _utilityController.toggleTrendingMovieSwitch();
                      _trendingItemController.resetMoviePage();

                      if (_utilityController.isMovieToday) {
                        _trendingItemController.getTrendingMovies(
                            timeWindow: StringConstant.day);
                      } else {
                        _trendingItemController.getTrendingMovies(
                            timeWindow: StringConstant.week);
                      }
                    },
                    child: Container(
                      padding: padding ??
                          const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _utilityController.isMovieToday ? 'Today' : 'This Week',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: AppTheme.white,
                            ),
                      ),
                    ),
                  ),
            const Icon(
              Icons.import_export,
              size: 16,
              color: AppTheme.white,
            ),
          ],
        ),
      ),
    );
  }
}
