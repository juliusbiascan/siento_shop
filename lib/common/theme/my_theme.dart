import 'package:flutter/material.dart';
import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_styles.dart';

class MyTheme {
  static getThemeData({required bool isLight}) {
    return ThemeData(
      useMaterial3: true,
      // main color (app bar,tabs..etc)
      primaryColor: isLight
          ? LightThemeColors.primaryColor
          : DarkThemeColors.primaryColor,
      // secondary color (for checkbox,float button, radio..etc)
      // secondary & background color
      colorScheme: ColorScheme.fromSwatch(
        accentColor: isLight
            ? LightThemeColors.accentColor
            : DarkThemeColors.accentColor,
        backgroundColor: isLight
            ? LightThemeColors.backgroundColor
            : DarkThemeColors.backgroundColor,
        brightness: isLight ? Brightness.light : Brightness.dark,
      ).copyWith(
        secondary: isLight
            ? LightThemeColors.accentColor
            : DarkThemeColors.accentColor,
      ),
      // color contrast (if the theme is dark text should be white for example)
      brightness: isLight ? Brightness.light : Brightness.dark,
      // card widget background color
      cardColor:
          isLight ? LightThemeColors.cardColor : DarkThemeColors.cardColor,
      // hint text color
      hintColor: isLight
          ? LightThemeColors.hintTextColor
          : DarkThemeColors.hintTextColor,
      // divider color
      dividerTheme: DividerThemeData(
        color: isLight
            ? LightThemeColors.dividerColor
            : DarkThemeColors.dividerColor,
      ),
      // app background color
      scaffoldBackgroundColor: isLight
          ? LightThemeColors.scaffoldBackgroundColor
          : DarkThemeColors.scaffoldBackgroundColor,

      // progress bar theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isLight
            ? LightThemeColors.primaryColor
            : DarkThemeColors.primaryColor,
      ),

      // appBar theme
      appBarTheme: MyStyles.getAppBarTheme(isLightTheme: isLight),

      // elevated button theme
      elevatedButtonTheme:
          MyStyles.getElevatedButtonTheme(isLightTheme: isLight),

      // text theme
      textTheme: MyStyles.getTextTheme(isLightTheme: isLight),

      // chip theme
      chipTheme: MyStyles.getChipTheme(isLightTheme: isLight),

      // icon theme
      iconTheme: MyStyles.getIconTheme(isLightTheme: isLight),
    );
  }
}
