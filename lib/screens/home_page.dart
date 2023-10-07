import 'package:covid_19_tracker/screens/search_screen.dart';
import 'package:covid_19_tracker/screens/track_me.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/home_screen.dart'; 

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
          int _selectedIndex = 0;
          static  List<Widget> _widgetOptions = <Widget>[
            const HomeScreen(),
            const SearchScreen(),
            LocationTrackingScreen(),

            
          ];

          void _onItemTapped(int index) {
            setState(() {
              _selectedIndex = index;
            });
          }
        
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.white10,
            elevation: 0,
            foregroundColor: Colors.black,
            centerTitle: true,
            floating: true,
            snap: true,
            title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/virus.png',scale: 22,),
            Text(
          ' Covid 19 Tracker',
             style: GoogleFonts.acme(fontWeight: FontWeight.w800, fontSize: 35, ),
             ),
          ]
        ), 
        ),
          
        ],
        body:Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/virus1.png"), 
                fit: BoxFit.cover),
        ),
          child: 
             _widgetOptions.elementAt(_selectedIndex),
             
        
      ),
        
        ),
         bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                label: 'Track Me',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.redAccent,
            onTap: (index) {
                 _onItemTapped(index);
            },
          ),
    );
  }
}
  