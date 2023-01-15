import 'package:flutter/material.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';

class ListHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? viewMoreTap;
  final Widget? additionalToggleWidget;

  const ListHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.additionalToggleWidget,
    this.viewMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(width: 4),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: AppTheme.primaryColorDark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(width: 8),
              additionalToggleWidget ?? const SizedBox.shrink(),
            ],
          ),
          IconButton(
            onPressed: viewMoreTap,
            icon: const Icon(
              Icons.arrow_forward,
              color: AppTheme.primaryColor_80,
            ),
          ),
        ],
      ),
    );
  }
}
