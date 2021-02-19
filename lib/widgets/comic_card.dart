import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel/marvel.dart';

class ComicCard extends StatelessWidget {
  String comicName;
  String comicDescription;
  String url;
  Function openComic;

  ComicCard({this.comicName, this.comicDescription, this.url, this.openComic});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  openComic();
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
                    style:
                        GoogleFonts.bangers(color: Colors.white, fontSize: 20),
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
}

// Widget ComicCard(String comicName, String comicDescription, String url) {
//   Function openComic;
//   return
// }

/*
Widget ComicCard(String comicName, String comicDescription, String url) {
  Function openComic;
  return Card(
    color: Colors.white.withOpacity(0),
    child: Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                print('pic clicked');
                openComic;
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

 */
