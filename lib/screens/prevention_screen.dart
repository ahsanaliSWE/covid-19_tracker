import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class WearMask extends StatelessWidget {
  final String imagePath = 'assets/images/01.png';

  const WearMask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
       body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
               title: Text('Wear a mask',
                            style: GoogleFonts.acme(
                             fontWeight: FontWeight.bold,
                             fontSize: 30,),
                            textAlign: TextAlign.center,
                            
                            ),
              backgroundColor: Colors.red.shade300,
              centerTitle: true,
              automaticallyImplyLeading: false,
        ),
        ],
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/virus1.png"), 
                fit: BoxFit.cover),
        ),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              height: 200, 
            ),
          ),
          const SizedBox(height: 20),
           
           Text(
            "Wearing a mask is a crucial step in preventing the spread of COVID-19. Masks act as a protective barrier, reducing the transmission of respiratory droplets that may contain the virus. It is recommended to wear masks in public settings, especially when social distancing is challenging.",
            style: GoogleFonts.acme(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      ),
       ),
    );
  }
}


class WashHands extends StatelessWidget {
  final String imagePath = 'assets/images/02.png';

  const WashHands({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
       body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
               title: Text('Wash Hands',
                            style: GoogleFonts.acme(
                             fontWeight: FontWeight.bold,
                             fontSize: 30,),
                            textAlign: TextAlign.center,
                            
                            ),
              backgroundColor: Colors.red.shade300,
              centerTitle: true,
              automaticallyImplyLeading: false,
        ),
        ],
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/virus1.png"), 
                fit: BoxFit.cover),
        ),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              height: 200, 
            ),
          ),
          const SizedBox(height: 20),
           
           Text(
            "Regular and thorough handwashing is essential in the fight against COVID-19. Wash your hands frequently with soap and water for at least 20 seconds to eliminate any potential virus on your hands. This practice is particularly important after being in public places or touching surfaces.",
            style: GoogleFonts.acme(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      ),
       ),
    );
  }
}

class Nrag extends StatelessWidget {
  final String imagePath = 'assets/images/03.png';

  const Nrag({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
       body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
               title: Text('Use Nose-Rag',
                            style: GoogleFonts.acme(
                             fontWeight: FontWeight.bold,
                             fontSize: 30,),
                            textAlign: TextAlign.center,
                            
                            ),
              backgroundColor: Colors.red.shade300,
              centerTitle: true,
              automaticallyImplyLeading: false,
        ),
        ],
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/virus1.png"), 
                fit: BoxFit.cover),
        ),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              height: 200, 
            ),
          ),
          const SizedBox(height: 20),
           
           Text(
            "When coughing or sneezing, use a tissue or your elbow to cover your nose and mouth. This helps prevent the spread of respiratory droplets containing the virus. Dispose of used tissues properly and follow up with hand hygiene to reduce the risk of infection.",
            style: GoogleFonts.acme(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      ),
       ),
    );
  }
}

class AvoidContact extends StatelessWidget {
  final String imagePath = 'assets/images/04.png';

  const AvoidContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
       body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
               title: Text('Avoid Contact',
                            style: GoogleFonts.acme(
                             fontWeight: FontWeight.bold,
                             fontSize: 30,),
                            textAlign: TextAlign.center,
                            
                            ),
              backgroundColor: Colors.red.shade300,
              centerTitle: true,
              automaticallyImplyLeading: false,
        ),
        ],
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/virus1.png"), 
                fit: BoxFit.cover),
        ),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              height: 200, 
            ),
          ),
          const SizedBox(height: 20),
           
           Text(
            "Practice social distancing by maintaining a safe distance (at least six feet) from others, especially if they show symptoms of illness. Minimize close contact with individuals outside your household and avoid crowded spaces. These measures are effective in reducing the risk of COVID-19 transmission.",
            style: GoogleFonts.acme(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      ),
       ),
    );
  }
}

