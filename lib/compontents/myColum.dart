import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyColum extends StatefulWidget {
  var image;
  var title;
  var screen;

  MyColum({super.key, required this.image, required this.title, required this.screen});

  @override
  _MyColumState createState() => _MyColumState();
}

class _MyColumState extends State<MyColum> {
  bool isHovered = false;
  bool isHolding = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (event) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovered = false;
            });
          },
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.screen,
                ),
              );
            },
            onLongPress: () {
              setState(() {
                isHolding = true;
              });
            },
            onLongPressUp: () {
              setState(() {
                isHolding = false;
              });
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
                color: isHovered || isHolding ? Colors.red : Colors.redAccent,
                boxShadow: [
                  if (isHovered || isHolding)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.title,
          style: const TextStyle(fontSize: 15, color: Colors.redAccent),
        ),
      ],
    );
  }
}
