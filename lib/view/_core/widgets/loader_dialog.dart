// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import '../../../_core/app_theme/app_theme.dart';

class AnimatedLoader extends StatelessWidget {
  const AnimatedLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: FittedBox(
          child: Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(1.2.h),
            ),
            child: Padding(
              padding: EdgeInsets.all(1.8.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppTheme.grey5),
                  ),
                  FittedBox(
                    child: Text(
                      "Just a second....",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppTheme.grey5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingSpinner {
  SpinKitFadingCircle fadingCircleSpinner = const SpinKitFadingCircle(
    // size: 14,
    color: AppTheme.primaryColor,
  );

  SpinKitFadingCircle miniFadingCircleSpinner = const SpinKitFadingCircle(
    size: 22,
    color: AppTheme.white,
  );

  SpinKitThreeBounce horizontalLoading = const SpinKitThreeBounce(
    size: 14,
    color: AppTheme.primaryColor_40,
  );
}
