import 'package:flutter/material.dart';
import '../utils/utils.dart' as utils;

class ThemeRepo {
  const ThemeRepo();

  static ThemeData get themeData => ThemeData(
        scaffoldBackgroundColor: utils.scaffoldBackgroundColor,
        primaryColor: utils.baseColor,
        primaryColorLight: Colors.white,
        primaryColorDark: utils.baseColor,
        errorColor: Colors.red,
        colorScheme: ThemeData().colorScheme.copyWith(
              brightness: Brightness.light,
              primary: utils.baseColor,
            ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: utils.bodyLargeTextColor,
            fontSize: utils.largePadding,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            color: utils.bodyLargeTextColor,
            fontSize: utils.padding,
            fontWeight: FontWeight.w300,
          ),
          bodySmall: TextStyle(
            color: utils.bodyLargeTextColor,
            fontSize: utils.padding - utils.tinyPadding,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: utils.baseColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: utils.baseColor,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              utils.baseColor,
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    utils.smallPadding,
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                utils.padding,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          modalBackgroundColor: Colors.transparent,
        ),
        cardTheme: const CardTheme(
          color: utils.baseColorLight,
          elevation: utils.nil,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                utils.padding,
              ),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: utils.floatingActionButtonColor,
          elevation: utils.nil,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          circularTrackColor: Colors.transparent,
          color: Colors.white.withOpacity(
            utils.nilDotFiveFive,
          ),
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          trackColor: MaterialStateProperty.all<Color>(
            Colors.black.withOpacity(
              utils.nilDotThreeThree,
            ),
          ),
          thumbVisibility: MaterialStateProperty.all<bool>(
            true,
          ),
          trackVisibility: MaterialStateProperty.all<bool>(
            true,
          ),
          mainAxisMargin: utils.padding,
          radius: const Radius.circular(
            utils.smallPadding + utils.veryTinyPadding,
          ),
          interactive: true,
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            utils.baseColorLight,
          ),
          splashRadius: utils.padding + utils.tinyPadding + utils.tinyPadding,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );
}
