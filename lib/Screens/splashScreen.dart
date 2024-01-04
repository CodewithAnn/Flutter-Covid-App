import 'dart:async';

import 'package:covid_app/Screens/Home/worldStat.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3.9.toInt()),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorldStat(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // for size
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            child: Container(
              height: _mediaQuery.size.height * 0.80,
              width: _mediaQuery.size.width * 1,
              child: Center(
                child: Image(
                    image: AssetImage('assets/images/covid-animated.png')),
              ),
            ),
            builder: (context, child) {
              return Transform.scale(
                scale: _animationController.value * 0.5,
                child: child,
              );
            },
          ),
          SizedBox(
            height: _mediaQuery.size.height * .02,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Covid-19\n \t App',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
