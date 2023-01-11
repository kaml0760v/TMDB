import 'package:flutter/material.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/controllers/trending_items_controller.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/widgets/loader_dialog.dart';

class TrendingMovieSwitchBtnBuilder extends StatelessWidget {
  final Color? color;
  final Color? selectedColor;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final PageType page;
  final bool isFetching;
  final bool isToday;
  final TrendingItemsController trendingController;
  final UtilityController utilityController;

  const TrendingMovieSwitchBtnBuilder({
    required this.trendingController,
    required this.utilityController,
    this.color,
    this.selectedColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.border,
    this.page = PageType.movie,
    this.isFetching = false,
    this.isToday = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final utilityController = Get.find<UtilityController>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: color ?? AppTheme.primaryColor,
        border: border,
      ),
      child: Row(
        children: [
          isFetching
              ? Container(
                  height: 20,
                  padding: padding ??
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: LoadingSpinner().horizontalLoading,
                )
              : GestureDetector(
                  onTap: () {
                    if (page == PageType.movie) {
                      utilityController.toggleTrendingMovieSwitch();
                      trendingController.resetMoviePage();

                      if (utilityController.isMovieToday) {
                        trendingController.getTrendingItems(
                            timeWindow: StringConstant.day,
                            page: PageType.movie);
                      } else {
                        trendingController.getTrendingItems(
                            timeWindow: StringConstant.week,
                            page: PageType.movie);
                      }
                    } else {
                      utilityController.toggleTrendingTvSwitch();
                      trendingController.resetTvPage();

                      if (utilityController.isTvToday) {
                        trendingController.getTrendingItems(
                            timeWindow: StringConstant.day, page: PageType.tv);
                      } else {
                        trendingController.getTrendingItems(
                            timeWindow: StringConstant.week, page: PageType.tv);
                      }
                    }
                  },
                  child: Container(
                    padding: padding ??
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isToday ? 'Today' : 'This Week',
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
    );
  }
}
