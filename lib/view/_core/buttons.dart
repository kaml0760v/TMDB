import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';

import 'presentation_method.dart';

class PrimaryButton extends StatelessWidget {
  final bool isDisabled;
  final bool isProgressing;
  final SIZES size;
  final Size? customSize;
  final TextStyle? customTextStyle;
  final String btnText;
  final double? horizPadding;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final EdgeInsets contentPadding;
  final Color? textColor;
  final BorderSide? borderSide;

  const PrimaryButton(
      {Key? key,
      this.size = SIZES.medium,
      this.isDisabled = false,
      this.isProgressing = false,
      required this.btnText,
      required this.onPressed,
      this.horizPadding = 30.0,
      this.buttonColor = AppTheme.primaryColor,
      this.customSize,
      this.customTextStyle,
      this.contentPadding = const EdgeInsets.all(2),
      this.textColor,
      this.borderSide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizPadding ?? 20.0),
      child: TextButton(
        onPressed: isDisabled
            ? null
            : isProgressing
                ? () {
                    showToast("Still processing!");
                  }
                : onPressed,
        style: Theme.of(context).textButtonTheme.style!.copyWith(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              )),
              side: MaterialStateProperty.all(borderSide),
              padding: contentPadding.wrapMatProp(),
              foregroundColor: isDisabled
                  ? AppTheme.grey2.wrapMatProp()
                  : buttonColor.wrapMatProp(),
              backgroundColor: isDisabled
                  ? AppTheme.grey5.wrapMatProp()
                  : buttonColor.wrapMatProp(),
              minimumSize: customSize != null
                  ? customSize!.wrapMatProp()
                  : size != SIZES.medium
                      ? Size(
                          (size == SIZES.extraSmall
                                  ? 20
                                  : size == SIZES.small
                                      ? 30
                                      : size == SIZES.large
                                          ? 50
                                          : 40)
                              .h,
                          100.h > 1000 && 100.w > 370 ? 5.5.h : 6.h,
                        ).wrapMatProp()
                      : null,
            ),
        child: isProgressing
            ? const SizedBox(
                height: 25.0,
                width: 25.0,
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation(AppTheme.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      btnText,
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle != null
                          ? customTextStyle!
                          : (size == SIZES.extraSmall || size == SIZES.small)
                              ? Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: isDisabled
                                        ? AppTheme.grey2
                                        : textColor ?? AppTheme.white,
                                  )
                              : size == SIZES.medium
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: isDisabled
                                            ? AppTheme.grey2
                                            : textColor ?? AppTheme.white,
                                      )
                                  : Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: isDisabled
                                            ? AppTheme.grey2
                                            : textColor ?? AppTheme.white,
                                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

enum SIZES {
  small,
  extraSmall,
  large,
  medium,
}
