import 'package:covid_app/Screens/country_list.dart';
import 'package:covid_app/model/covid_world_stats.dart';
import 'package:covid_app/services/utilliteis/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    // object of World stats api
    StatServices _statsServices = StatServices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: _mediaQuery.size.height * 0.01,
              ),
              FutureBuilder(
                future: _statsServices.fetchWordStats(),
                builder: (context, AsyncSnapshot<CovidWorldStats> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString()),
                            "Recover": double.parse(
                                snapshot.data!.recovered.toString())
                          },
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          chartRadius: _mediaQuery.size.width / 3.9,
                          colorList: _colorList,
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false),
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
                                _reUseableRow(
                                    title: "Cases",
                                    value: snapshot.data!.cases.toString()),
                                _reUseableRow(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                _reUseableRow(
                                    title: "Today cases",
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                _reUseableRow(
                                    title: "Today Deaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                _reUseableRow(
                                    title: "Total Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                _reUseableRow(
                                    title: "Active Cases",
                                    value: snapshot.data!.active.toString()),
                                _reUseableRow(
                                    title: "Affected Countries",
                                    value: snapshot.data!.affectedCountries
                                        .toString()),
                                _reUseableRow(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                              ],
                            ),
                          ),
                        ),
                        // Elevated Button for Tracking Countries Data
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CountryList(),
                                ));
                          },
                          child: Text("Track Country Data"),
                        ),
                      ],
                    );
                  } else {
                    return Expanded(
                        flex: 1,
                        child: SpinKitThreeInOut(
                          color: Colors.red,
                          size: 60,
                          controller: _animationController,
                        ));
                  }
                },
              ),
            ],
          ),
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
