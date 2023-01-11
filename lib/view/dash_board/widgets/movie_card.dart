import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/models/movies.dart';

class MovieCard extends StatelessWidget {
  final Items movies;
  final String posterUrl;
  const MovieCard({
    super.key,
    required this.movies,
    required this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.w,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: movies.posterPath == null
            ? Container(
                alignment: Alignment.center,
                width: 94,
                height: 140,
                color: Colors.black12,
                child: const Icon(
                  Icons.error_outline,
                  color: AppTheme.white,
                  size: 34,
                ),
              )
            : CachedNetworkImage(
                width: 94,
                height: 140,
                fit: BoxFit.fill,
                imageUrl: '$posterUrl${movies.posterPath}',
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                ),
              ),
      ),
    );
  }
}
