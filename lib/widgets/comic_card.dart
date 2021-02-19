import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel/marvel.dart';

Widget ComicCard(String comicName, String comicDescription, String url) {
  return Card(
    color: Colors.white.withOpacity(0),
    child: Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                print('pic clicked');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.fill,
                  width: 216,
                  height: 324,
                  image: url,
                  placeholder: 'images/marvelLogo.png',
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  comicName ?? "",
                  style: GoogleFonts.bangers(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  comicDescription ?? "",
                  style: GoogleFonts.itim(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
