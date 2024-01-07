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
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _mediaQuery.size.height * 0.06,
                  horizontal: _mediaQuery.size.width * 0.029),
              child: Card(
                child: Column(
                  children: [
                    _reUseableRow(title: "Total", value: "300"),
                    _reUseableRow(title: "Total", value: "300"),
                    _reUseableRow(title: "Total", value: "300"),
                    _reUseableRow(title: "Total", value: "300"),
                  ],
                ),
              ),
            ),
            // Elevated Button for Tracking Countries Data
            ElevatedButton(
              onPressed: () {},
              child: Text("Track Country Data"),
            ),
          ],
        ),
      ),
    );
  }

// method for using row multiple times
  Widget _reUseableRow({required String title, required String value}) =>
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 8, top: 12, bottom: 9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(),
          ],
        ),
      );
}
