import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStat extends StatefulWidget {
  const WorldStat({super.key});

  @override
  State<WorldStat> createState() => _WorldStatState();
}

class _WorldStatState extends State<WorldStat> with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  final _colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: _mediaQuery.size.height * 0.01,
            ),
            PieChart(
              dataMap: {"Total": 100, "Death": 68, "Recover": 32},
              animationDuration: Duration(milliseconds: 1200),
              chartType: ChartType.ring,
              chartRadius: _mediaQuery.size.width / 3.6,
              colorList: _colorList,
              legendOptions: LegendOptions(
                legendPosition: LegendPosition.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
