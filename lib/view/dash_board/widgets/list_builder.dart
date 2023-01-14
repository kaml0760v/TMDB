import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/configration_controller.dart';
import '../../../controllers/trending_items_controller.dart';
import '../../../controllers/utility_controller.dart';
import '../../../models/movies.dart';
import 'list_header.dart';
import 'movie_card.dart';
import 'trending_movie_switch.dart';

class ListBuilder extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget? additinalWidget;
  final RxList<Items> items;

  const ListBuilder({
    super.key,
    required this.title,
    required this.subTitle,
    required this.items,
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
          viewMoreTap: () {},
          additionalToggleWidget: additinalWidget,
        ),
        SizedBox(
          height: 200,
          child: Obx(
            () {
              return ListView.builder(
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movies: items[index],
                    posterUrl: configController.posterUrl,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
