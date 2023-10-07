import 'package:covid_19_tracker/components/re_row.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class CountryInfoScreen extends StatefulWidget {
  final dynamic country;

  const CountryInfoScreen({Key? key, required this.country}) : super(key: key);

  @override
  _CountryInfoScreenState createState() => _CountryInfoScreenState();
}

class _CountryInfoScreenState extends State<CountryInfoScreen> {
  Map<String, dynamic> reports = {};
  bool isLoading2 = true;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://disease.sh/v3/covid-19/countries/${widget.country['countryInfo']['iso2']}',
        ),
      );

      if (response.statusCode == 200) {
        final parsedReports = json.decode(response.body);
        setState(() {
          reports = parsedReports;
          isLoading2 = false;
        });
      } else {
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Data Available'),
          content: const Text('Try Again Later.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context,'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
        throw Exception('Failed to load Data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.red.shade200,
     body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.red.shade200,
        elevation: 0,
       // foregroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.country['country'],
              style: GoogleFonts.acme(
                fontWeight: FontWeight.w800,
                fontSize: 35,
              ),
            ),
          ],
        ),
        ),
        ],
      
      body: SingleChildScrollView(
        child: SafeArea(
          child: isLoading2
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top:
                                  MediaQuery.of(context).size.height * .067),
                          child: Card(
                            color: Colors.red.shade300,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      .06,
                                ),
                                Image.network(widget.country['countryInfo']['flag']),
                                
                                ReusableRow(
                                  title: 'Continent:',
                                  value: '${reports['continent']}',
                                ),
                                ReusableRow(
                                  title: 'Population:',
                                  value: '${reports['population']}',
                                ),
                                ReusableRow(
                                  title: 'Cases:',
                                  value: '${reports['cases']}',
                                ),
                                ReusableRow(
                                  title: 'Tests:',
                                  value: '${reports['tests']}',
                                ),
                                ReusableRow(
                                  title: 'Critical:',
                                  value: '${reports['critical']}',
                                ),
                                ReusableRow(
                                  title: 'Deaths:',
                                  value: '${reports['deaths']}',
                                ),
                                ReusableRow(
                                  title: 'Recovered:',
                                  value: '${reports['recovered']}',
                                ),
                                ReusableRow(
                                  title: 'Active:',
                                  value: '${reports['active']}',
                                ),
                                ReusableRow(
                                  title: 'Today Cases:',
                                  value: '${reports['todayCases']}',
                                ),
                                ReusableRow(
                                  title: 'Today Deaths:',
                                  value: '${reports['todayDeaths']}',
                                ),
                                ReusableRow(
                                  title: 'Today Recovered:',
                                  value: '${reports['todayRecovered']}',
                                ),
                                
                                
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      ),
    );
  }
}

