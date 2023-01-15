import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';
import 'package:tmdp_getx_mvc/controllers/configration_controller.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configController = Get.find<ConfigurationController>();
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Auth.isGuestLoggedIn
                ? const Text("guest")
                : GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.profile);
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: (Auth.getAvatar ?? "").isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppTheme.grey1,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: AppTheme.white,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: '${configController.profileUrl}${Auth.getAvatar}',
                                fit: BoxFit.scaleDown,
                                errorWidget: (context, url, error) => Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: AppTheme.grey1,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: AppTheme.white,
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  color: AppTheme.grey1,
                                ),
                              ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      centerTitle: true,
      title: Text(
        "TMDB",
        style: Theme.of(context).textTheme.subtitle2?.copyWith(color: AppTheme.white),
      ),
    );
  }
}
