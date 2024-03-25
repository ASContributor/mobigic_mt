import 'package:flutter/material.dart';
import 'package:mobigic_mt/View/GridView/GridviewDetail.dart';
import 'package:mobigic_mt/View/Input_screen/inputPage.dart';

import 'package:mobigic_mt/View/splash_screen.dart';

class AppRoute {
  static const String splashScreen = '/';
  static const String gridviewDetailScreen = '/GridviewDetail';
  static const String InputScreen = '/InputScreen';
  static const String WordSearch = '/WordSearchScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case InputScreen:
        return MaterialPageRoute(builder: (context) => const InputPage());
      case gridviewDetailScreen:
        return MaterialPageRoute(
          builder: (context) => const GridviewDetail(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
