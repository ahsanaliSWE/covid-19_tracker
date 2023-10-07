import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'country_info.dart';

class LocationTrackingScreen extends StatefulWidget {
  @override
  _LocationTrackingScreenState createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  Position? _currentPosition;
  String country = 'Loading...';
  // ignore: non_constant_identifier_names
  bool? on_off = true;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });

      await _getAddressFromLatLng(_currentPosition!);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        setState(() {
          country = placemarks[0].country ?? 'Not Found';
        });
      } else {
        setState(() {
          country = 'Not Found';
        });
      }
    } catch (e) {
      setState(() {
        country = 'Error getting location';
        on_off = false;
      });
    }
  }

  Future<void> _fetchCountryInfo() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://disease.sh/v3/covid-19/countries/$country',
        ),
      );

      if (response.statusCode == 200) {
        // Parse the response
        final Map<String, dynamic> countryInfo = json.decode(response.body);

        // Navigate to CountryInfoScreen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CountryInfoScreen(country: countryInfo),
          ),
        );
      } else {
        // Handle API error
      }
    } catch (e) {
      // Handle other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Your current country:',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          country,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: on_off == true ? _fetchCountryInfo : null,
          child: const Text('Show Country Info'),
        ),
      ],
    );
  }
}
