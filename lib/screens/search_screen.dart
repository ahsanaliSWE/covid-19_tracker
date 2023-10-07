
import 'package:covid_19_tracker/screens/country_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> countries = [];
  List<dynamic> filteredCountries = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true; // Track whether data is being fetched

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

 Future<void> fetchCountries() async {
  try {
    final response = await http.get(
      Uri.parse('https://disease.sh/v3/covid-19/countries'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> parsedCountries = json.decode(response.body);
      
      setState(() {
        countries = parsedCountries;
        isLoading = false; // Data fetching is complete
      });
    } 
  } catch (error) {
    
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet connection and try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    
  }
}


  void filterCountries(String query) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country['country'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void showCountryInfo(BuildContext context, dynamic country) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CountryInfoScreen(country: country),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onChanged: filterCountries,
            decoration:  InputDecoration(
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
              borderSide:
                   const BorderSide(width: 3, color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(50.0),
               ),      
              hintText: 'Search Country',
              prefixIcon: const Icon(Icons.search,color: Colors.redAccent,),

            ),
          ),
        ),
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              :  ListView.builder(
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    return ListTile(
                      onTap: () => showCountryInfo(context, country),
                      leading: Image.network(country['countryInfo']['flag'],scale: 2,),
                      title: Text(country['country'],
                               style: GoogleFonts.acme(),),
                      subtitle: Text('Cases: ${country['cases']}',
                                      style: GoogleFonts.acme(),),
                    );
                  },
                ),
              
        ),
      ],
    );
  }
}

