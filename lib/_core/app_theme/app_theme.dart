import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();
  static const primaryColor = Color(0xFF203066);
  static const primaryColor_80 = Color(0xFF203066);
  static const primaryColor_60 = Color(0xFF203066);
  static const primaryColor_40 = Color(0xFF949BB5);
  static const primaryColor_30 = Color(0xFFD9DFE9);
  static const primaryColor_20 = Color(0xFFE9EBF0);
  static const primaryColor_10 = Color(0xFFF4F5F7);
  static const primaryColor_5 = Color(0xFFFBFBFC);
  static const primaryColorLight = Color(0xFF36298B);
  static const primaryColorDark = Color(0xFF21027A);

  static const accent1 = Color(0xFF4CAA3D);
  static const accent2 = Color(0xFF4B58BD);
  static const accent3 = Color(0xFF714170);
  static const accent4 = Color(0xFF003F63);
  static const accent5 = Color(0xFF0095A5);
  static const accent6 = Color(0xFFC15DBF);

  static const grey1 = Color(0xFF464646);
  static const grey2 = Color(0xFF909090);
  static const grey3 = Color(0xFFE4E4E4);
  static const grey4 = Color(0xFFF1F1F1);
  static const grey5 = Color(0xFFF9F9F9);
  static const darkGrey = Color(0xFF181818);

  static const black = Color(0xFF001A28);
  static const bgColor = Color(0xFFFFFFFF);
  static const gradientColor = Color(0xFF36298B);
  static const inActiveTabColor = Color(0xFFFFD0C7);

  static const trustBadgeColor = Color(0xFF5DA9C1);
  static const pioneerBadgeColor = Color(0xFF7D5DC1);
  static const helperBadgeColor = Color(0xFF5DC1B5);
  static const splashTextBackgroundColor = Color(0xFF4D5985);
  static const error = Color(0xffE63C1E);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    fontFamily: 'Comfortaa',
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: primaryColor,
        secondary: primaryColor_80,
        onSecondary: primaryColor_80,
        error: error,
        onError: error,
        background: grey5,
        onBackground: grey5,
        surface: black,
        onSurface: black),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.resolveWith((states) => primaryColor),
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => primaryColor),
      ),
    ),
  );

  static const TextTheme lightTextTheme = TextTheme(
    headline1: _headline1,
    headline2: _headline2,
    headline3: _headline3,
    subtitle1: _subtitle1,
    subtitle2: _subtitle2,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
    caption: _caption,
    button: _buttonText,
  );

  static const TextStyle _headline1 = TextStyle(
    color: black,
    fontSize: 36.0,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _headline2 = TextStyle(
    color: black,
    fontSize: 30.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _headline3 = TextStyle(
    color: black,
    fontSize: 23.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _subtitle1 = TextStyle(
    color: black,
    fontSize: 21.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _subtitle2 = TextStyle(
    color: black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _bodyText1 = TextStyle(
    color: black,
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _bodyText2 = TextStyle(
    color: black,
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _caption = TextStyle(
    color: black,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _buttonText = _bodyText1;
}

extension MaterialPropX<T> on T {
  MaterialStateProperty<T> wrapMatProp() =>
      MaterialStateProperty.resolveWith<T>((states) => this);
}
