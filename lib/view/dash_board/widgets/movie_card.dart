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
    return GestureDetector(
      onTap: (movies.posterPath ?? "").isEmpty
          ? () {}
          : () {
              //TODO:
            },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                width: 35.w,
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: movies.posterPath == null
                      ? Container(
                          alignment: Alignment.center,
                          width: 35.w,
                          // height: 180,
                          color: Colors.black12,
                          child: const Icon(
                            Icons.error_outline,
                            color: AppTheme.white,
                            size: 34,
                          ),
                        )
                      : CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: '$posterUrl${movies.posterPath}',
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                          ),
                        ),
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppTheme.grey1),
                  child: Text(
                    '${movies.voteAverage}',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: AppTheme.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(4),
            width: 35.w,
            child: Text(
              movies.title ?? movies.name ?? "",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
