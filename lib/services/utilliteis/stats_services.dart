import 'dart:convert';

import 'package:covid_app/Screens/country_list.dart';
import 'package:covid_app/model/covid_world_stats.dart';
import 'package:covid_app/services/utilliteis/app_url.dart';
import 'package:http/http.dart' as http;

class StatServices {
  final uri = Uri.parse(AppUrl.worldStateApi);

  Future<CovidWorldStats> fetchWordStats() async {
    final response = await http.get(uri);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return CovidWorldStats.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  // fetch data county wise
  final countyUri = Uri.parse(AppUrl.countryData);

  Future<List<dynamic>> fetchCountyList() async {
    final response = await http.get(countyUri);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
