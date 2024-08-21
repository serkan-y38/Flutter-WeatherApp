import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: MaterialTheme.lightScheme());

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: MaterialTheme.darkScheme());

enum AppTheme { themeKey, light, dark, systemSetting }

class ThemeUtils {
  static ThemeData getThemeData(AppTheme theme, BuildContext context) {
    ThemeData themeData;
    if (theme == AppTheme.dark) {
      themeData = darkTheme;
    } else if (theme == AppTheme.light) {
      themeData = lightTheme;
    } else {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        themeData = darkTheme;
      } else {
        themeData = lightTheme;
      }
    }
    _setSystemBarsColor(themeData);
    return themeData;
  }

  static void _setSystemBarsColor(ThemeData theme) {
    SystemUiOverlayStyle systemUiOverlayStyle;
    if (theme == lightTheme) {
      systemUiOverlayStyle = SystemUiOverlayStyle(
        systemNavigationBarColor: MaterialTheme.lightScheme().surface,
        statusBarColor: MaterialTheme.lightScheme().surface,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark
      );
    } else {
      systemUiOverlayStyle = SystemUiOverlayStyle(
        systemNavigationBarColor: MaterialTheme.darkScheme().surface,
        statusBarColor: MaterialTheme.darkScheme().surface,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      );
    }
    _setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  static Future<void> _setSystemUIOverlayStyle(
      SystemUiOverlayStyle style) async {
    await Future.delayed(const Duration(milliseconds: 100));
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006879),
      surfaceTint: Color(0xff006879),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa8edff),
      onPrimaryContainer: Color(0xff001f26),
      secondary: Color(0xff4b6268),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee7ee),
      onSecondaryContainer: Color(0xff061f24),
      tertiary: Color(0xff565d7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdde1ff),
      onTertiaryContainer: Color(0xff121a37),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484b),
      outline: Color(0xff6f797b),
      outlineVariant: Color(0xffbfc8cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff84d2e5),
      primaryFixed: Color(0xffa8edff),
      onPrimaryFixed: Color(0xff001f26),
      primaryFixedDim: Color(0xff84d2e5),
      onPrimaryFixedVariant: Color(0xff004e5b),
      secondaryFixed: Color(0xffcee7ee),
      onSecondaryFixed: Color(0xff061f24),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff334a50),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff121a37),
      tertiaryFixedDim: Color(0xffbec5eb),
      onTertiaryFixedVariant: Color(0xff3e4565),
      surfaceDim: Color(0xffd5dbdd),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f6),
      surfaceContainer: Color(0xffe9eff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff84d2e5),
      surfaceTint: Color(0xff84d2e5),
      onPrimary: Color(0xff00363f),
      primaryContainer: Color(0xff004e5b),
      onPrimaryContainer: Color(0xffa8edff),
      secondary: Color(0xffb2cbd2),
      onSecondary: Color(0xff1c3439),
      secondaryContainer: Color(0xff334a50),
      onSecondaryContainer: Color(0xffcee7ee),
      tertiary: Color(0xffbec5eb),
      onTertiary: Color(0xff272f4d),
      tertiaryContainer: Color(0xff3e4565),
      onTertiaryContainer: Color(0xffdde1ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8cb),
      outline: Color(0xff899295),
      outlineVariant: Color(0xff3f484b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff006879),
      primaryFixed: Color(0xffa8edff),
      onPrimaryFixed: Color(0xff001f26),
      primaryFixedDim: Color(0xff84d2e5),
      onPrimaryFixedVariant: Color(0xff004e5b),
      secondaryFixed: Color(0xffcee7ee),
      onSecondaryFixed: Color(0xff061f24),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff334a50),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff121a37),
      tertiaryFixedDim: Color(0xffbec5eb),
      onTertiaryFixedVariant: Color(0xff3e4565),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
