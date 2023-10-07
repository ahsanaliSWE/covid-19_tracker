import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyContainer extends StatelessWidget {
  var title;
  var image;
  MyContainer({super.key,required this.image,required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior:Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15,5,1),
              child: Container(
                height: 130,
                decoration:  BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                  color:Colors.redAccent.shade200,
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        height:150,
                        width:190,
                        child:Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                          Text(title,style: GoogleFonts.acme(fontSize:20,color:Colors.white),)
                    ],)),
                  ],
                ),
              )
            ),
            Positioned(
              top:-35,
                left:20,
                child:Container(
                  height:190,
                  width:160,
                  decoration:BoxDecoration(
                    image:DecorationImage(image:AssetImage(image),
                  ),
                ),
            )
            ),
          ],
        ),
      ],
    );
  }
}
