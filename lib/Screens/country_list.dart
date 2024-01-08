import 'package:covid_app/services/utilliteis/stats_services.dart';
import 'package:flutter/material.dart';

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
                    },
                  );
                } else {
                  return Text('Loding');
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
