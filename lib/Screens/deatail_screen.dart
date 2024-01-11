import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.cases,
    required this.critical,
    required this.deaths,
    required this.recovered,
    required this.todayCases,
    required this.todayDeaths,
    required this.active,
    required this.todayRecovered,
    required this.tests,
  });

  final String name;
  final String image;
  final int cases,
      deaths,
      recovered,
      todayCases,
      todayDeaths,
      critical,
      todayRecovered,
      active,
      tests;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      _reUseableRow(
                        title: "Cases",
                        value: widget.cases.toString(),
                      ),
                      _reUseableRow(
                        title: "Deaths",
                        value: widget.deaths.toString(),
                      ),
                      _reUseableRow(
                        title: "Recovered",
                        value: widget.recovered.toString(),
                      ),
                      _reUseableRow(
                        title: "TodayCases",
                        value: widget.todayCases.toString(),
                      ),
                      _reUseableRow(
                        title: "TodayDeaths",
                        value: widget.todayDeaths.toString(),
                      ),
                      _reUseableRow(
                        title: "TodayRecovered",
                        value: widget.todayRecovered.toString(),
                      ),
                      _reUseableRow(
                        title: "Critical",
                        value: widget.critical.toString(),
                      ),
                      _reUseableRow(
                        title: "ActiveCases",
                        value: widget.active.toString(),
                      ),
                      _reUseableRow(
                        title: "Tests",
                        value: widget.tests.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}

// method for using row multiple times
Widget _reUseableRow({required String title, required String value}) => Padding(
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
