class AppUrl {
  // base url
  static const String baseUrl = "https://disease.sh/v3/covid-19/";

  // fetch world covid data
  static const String worldStateApi = baseUrl + 'all';
  // fetch country wise data
  static String countryData = baseUrl + 'country';
}
