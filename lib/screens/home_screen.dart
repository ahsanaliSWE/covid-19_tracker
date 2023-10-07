import 'dart:convert';
import 'package:covid_19_tracker/components/myColum.dart';
import 'package:covid_19_tracker/components/myContainer.dart';
import 'package:covid_19_tracker/screens/prevention_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> covidData;
  List<CovidData> lineChartSpots = [];

  final controller=PageController(viewportFraction:0.899,keepPage:true);

  @override
  void initState() {
    super.initState();
    covidData = fetchData();
  }

  
Future<Map<String, dynamic>> fetchData() async {
  try {
    final response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      Map<String, double> dataMap = {
        "cases": data['cases'].toDouble(),
        "active": data['active'].toDouble(),
        "recovered": data['recovered'].toDouble(),
        "deaths": data['deaths'].toDouble(),
        "critical": data['critical'].toDouble(),
        "tests": data['tests'].toDouble(),
        "todayCases": data['todayCases'].toDouble(),
        "todayDeaths": data['todayDeaths'].toDouble(),
        "todayRecovered": data['todayRecovered'].toDouble(),
        "affectedCountries": data['affectedCountries'].toDouble(),

      };

      // Store data in the database
      await DatabaseHelper.instance.insertCovidData(dataMap);

      return data;
    } else {
      // API call failed, try to retrieve data from the database
      try {
        Map<String, double> storedData = await DatabaseHelper.instance.getCovidData();
        lineChartSpots = storedData.entries
            .map((entry) => CovidData(entry.key, entry.value))
            .toList();
        return storedData;
      } catch (e) {
        throw Exception('Failed to load data from both API and database');
      }
    }
  } catch (e) {
    // Handle no internet connection or other errors

    try {
      // Try to retrieve data from the database when the API call fails
      Map<String, double> storedData = await DatabaseHelper.instance.getCovidData();
      lineChartSpots = storedData.entries
          .map((entry) => CovidData(entry.key, entry.value))
          .toList();
      return storedData;
    } catch (e) {
      // Handle database retrieval failure
      throw Exception('Failed to load data from both API and database');
    }
  }
}

      
      final pages = [
      MyContainer(image:'assets/images/symp2.png',title:'Four Symptoms \nof Covid-19',),
      MyContainer(image:'assets/images/fever1.png',title:'1 Fever or chills ',),
      MyContainer(image:'assets/images/cough.png',title:'2 Cough',),
      MyContainer(image:'assets/images/sneezing.png',title:'3 Congestion\nor runny nose',),
      MyContainer(image:'assets/images/headache.png',title:'4 Headache',),
    ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 156,
                  child: PageView.builder(
                    controller: controller,
                    // itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return pages[index % pages.length];
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count:pages.length,
                  effect: const ExpandingDotsEffect(
                      dotColor:  Colors.black26,
                      dotHeight:9,
                      dotWidth:9,
                      activeDotColor:  Colors.redAccent
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10,vertical:15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(17,0,0,15),
                  child: Row(
                    children:   [
                      Text('Preventions',style: GoogleFonts.acme(fontSize:25,letterSpacing:2),),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children:   [
                    MyColum(image:'assets/images/01.png',title:'Wear Mask', screen: const WearMask(),),
                    MyColum(image:'assets/images/02.png',title:'Wash Hands', screen: const WashHands(),),
                    MyColum(image:'assets/images/03.png',title:'Use nose-rag', screen: const Nrag(),),
                    MyColum(image:'assets/images/04.png',title:'Avoid Contact', screen: const AvoidContact(),)
                  ],
                ),

              ],
            ),
          ),
          Center(
            child: FutureBuilder<Map<String, dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                  
                } else {
                  final data = snapshot.data!;
                  Map<String, double> dataMap = {
                    "Cases": data['cases'].toDouble(),
                    "Active": data['active'].toDouble(),
                    "Recovered": data['recovered'].toDouble(),
                    "Deaths": data['deaths'].toDouble(),
                    "Critical": data['critical'].toDouble(),
                    "Tests": data['tests'].toDouble(),
                  };

                  Map<String, double> dataMap2 = {
                    "Today Cases": data['todayCases'].toDouble(),
                    "Today Deaths": data['todayDeaths'].toDouble(),
                    "Today Recovered": data['todayRecovered'].toDouble(),
                    "Affected Countries": data['affectedCountries'].toDouble(),
                  };


                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                            '\nWorldwide Covid-19 Cases',
                            style: GoogleFonts.acme(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      Text('Statistics',
                          style: GoogleFonts.acme(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                      Center(
                        child: SizedBox(
                          height: 300,
                          child: SfCircularChart(
                            legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                            ),
                            series: <CircularSeries>[
                              PieSeries<CovidData, String>(
                                dataSource: dataMap.entries
                                    .map((entry) =>
                                        CovidData(entry.key, entry.value))
                                    .toList(),
                                xValueMapper: (CovidData data, _) =>
                                    data.category,
                                yValueMapper: (CovidData data, _) => data.value,
                                dataLabelMapper: (CovidData data, _) =>
                                    '${data.category}: ${data.value}',
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  labelPosition: ChartDataLabelPosition.outside,
                                  textStyle: GoogleFonts.acme(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent[400],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                     
                      SizedBox(
                        height: 300,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            LineSeries<CovidData, String>(
                              dataSource: dataMap2.entries
                                  .map((entry) =>
                                      CovidData(entry.key, entry.value))
                                  .toList(),
                              xValueMapper: (CovidData covidData, _) =>
                                  covidData.category,
                              yValueMapper: (CovidData covidData, _) =>
                                  covidData.value,
                            ),
                          ],
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        // Reload data when the button is pressed
                        setState(() {
                          covidData = fetchData();
                        });
                      },
                      child: const Text('Reload!'),
                    ),                      
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CovidData {
  final String category;
  final double value;

  CovidData(this.category, this.value);
}
