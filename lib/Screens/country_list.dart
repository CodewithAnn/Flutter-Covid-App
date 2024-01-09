import 'package:covid_app/services/utilliteis/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatServices _statServices = StatServices();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by Country name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _statServices.fetchCountyList(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // storing country name for search
                      String _name = snapshot.data![index]['country'];

                      if (_searchController.text.isEmpty) {
                        // if user search nothing then
                        // it is showing list Countries with cases
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                snapshot.data![index]['country'].toString(),
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              leading: Image(
                                height: 70,
                                width: 70,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']["flag"],
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (_name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase())) {
                        // if search name is matched with country name then it is showing
                        // the matched countries with cases
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                snapshot.data![index]['country'].toString(),
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              leading: Image(
                                height: 70,
                                width: 70,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']["flag"],
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        // otherwise show nothing just empty screen
                        return Container();
                      }
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      // shimmer effect
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              // country name empty(shimmer)
                              title: Container(
                                height: 7,
                                width: 60,
                                color: Colors.white,
                              ),
                              //  cases empty(shimmer)
                              subtitle: Container(
                                height: 7,
                                width: 60,
                                color: Colors.white,
                              ),
                              // country flag empty(shimmer)
                              leading: Container(
                                height: 70,
                                width: 70,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
