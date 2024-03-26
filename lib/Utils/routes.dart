import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobigic_mt/View/GridView/GridviewDetail.dart';
import 'package:mobigic_mt/View/Input_screen/InputBloc/input_bloc.dart';
import 'package:mobigic_mt/View/Input_screen/inputPage.dart';

import 'package:mobigic_mt/View/splash_screen.dart';

class AppRoute {
  static const String splashScreen = '/';
  static const String gridviewDetailScreen = '/GridviewDetail';
  static const String InputScreen = '/InputScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case InputScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => InputBloc(),
                  child: const InputPage(),
                ));
      case gridviewDetailScreen:
        return MaterialPageRoute(
          builder: (context) =>
              GridviewDetail(inputBloc: settings.arguments as InputBloc),
        );
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
