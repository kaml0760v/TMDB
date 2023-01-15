import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../_core/app_theme/app_theme.dart';
import '../../../controllers/configration_controller.dart';
import '../../../models/movies.dart';
import '../../_core/widgets/loader_dialog.dart';
import 'list_header.dart';
import 'movie_card.dart';

class ListBuilder extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget? additinalWidget;
  final List<Items> items;
  final bool isLoadingMore;
  final VoidCallback onAddMoreTap;
  final VoidCallback viewMoreTap;

  const ListBuilder({
    super.key,
    required this.title,
    required this.subTitle,
    required this.items,
    required this.onAddMoreTap,
    required this.viewMoreTap,
    this.isLoadingMore = false,
    this.additinalWidget,
  });

  @override
  Widget build(BuildContext context) {
    final configController = Get.find<ConfigurationController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListHeader(
          title: title,
          subTitle: subTitle,
          viewMoreTap: viewMoreTap,
          additionalToggleWidget: additinalWidget,
        ),
        SizedBox(
          height: 240,
          child: Obx(
            () {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  itemCount: items.length + 1,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return items.length == index
                        ? GestureDetector(
                            onTap: onAddMoreTap,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              alignment: Alignment.center,
                              width: 35.w,
                              height: 200,
                              decoration: BoxDecoration(
                                color: AppTheme.grey3,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: isLoadingMore
                                  ? LoadingSpinner().fadingCircleSpinner
                                  : const Icon(
                                      Icons.add,
                                      color: AppTheme.white,
                                      size: 34,
                                    ),
                            ),
                          )
                        : MovieCard(
                            movies: items[index],
                            posterUrl: configController.posterUrl,
                          );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
