import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/animations/heroanimationsss/heromain.dart';

class HeroDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HeroMain())),
          child: Hero(
            tag: "imageHero",
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.yellow),
              width: 300,
              height: 300,
              child: const Icon(
                Icons.playlist_add_circle_rounded,
                size: 100,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}