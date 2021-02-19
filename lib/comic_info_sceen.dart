import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'marvel.dart';

class ComicInfoScreen extends StatelessWidget {
  Marvel _marvel = Marvel();
  String comicInfoData;
  ComicInfoScreen(this.comicInfoData);
  @override
  Widget build(BuildContext context) {
    print(comicInfoData);
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      _marvel.getImageUrl(comicInfoData, 0),
                    ),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            )),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Spacer(),
                Text(
                  _marvel.getComicTitle(comicInfoData, 0),
                  style: GoogleFonts.anton(color: Colors.white, fontSize: 25),
                ),
                Spacer(),
                Text(
                  _marvel.getComicDescription(comicInfoData, 0),
                  style: GoogleFonts.itim(color: Colors.white, fontSize: 20),
                ),
                Spacer(),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
/*  void myAnimation() {
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
      upperBound: 9,
    );

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
    });
  }

 */
