import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobigic_mt/Utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    delayedNevagator();
    super.initState();
  }

  Future delayedNevagator() {
    return Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoute.InputScreen, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 162, 162, 162),
        body: Center(
            child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: [
                Image(
                  image: AssetImage('assets/images.png'),
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                LoadingAnimationWidget.threeRotatingDots(
                    color: Colors.blue, size: 40)
              ]),
            ),
          ),
        )));
  }
}
