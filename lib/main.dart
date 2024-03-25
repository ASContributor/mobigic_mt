import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobigic_mt/Utils/routes.dart';
import 'package:mobigic_mt/View/Input_screen/InputBloc/input_bloc.dart';
import 'package:mobigic_mt/View/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InputBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoute.onGenerateRoute,
        initialRoute: AppRoute.splashScreen,
      ),
    );
  }
}
