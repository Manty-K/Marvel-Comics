import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel/comic_screen.dart';
import 'marvel.dart';

class CharacterScreen extends StatelessWidget {
  int index;
  String data;
  Marvel _marvel = Marvel();
  CharacterScreen(this.data, this.index);

  int characterId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(_marvel.getCharacterName(data, index),
            style: GoogleFonts.anton(fontSize: 40)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  _marvel.getImageUrl(data, index),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _marvel.getCharacterDescription(data, index),
              style: GoogleFonts.itim(color: Colors.white, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Featured in ' +
                  _marvel.getAvailableComic(data, index).toString() +
                  ' Comics',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            GestureDetector(
              onTap: () {
                // print(_marvel.getAvailableComic(data, index));
                // print('characterId' +
                //   _marvel.getCharacterID(data, index).toString());
                if (_marvel.getAvailableComic(data, index) > 0)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComicScreen(
                        _marvel.getCharacterID(data, index),
                        _marvel.getAvailableComic(data, index),
                        _marvel.getCharacterName(data, index),
                      ),
                    ),
                  );
              },
              child: Text(
                'Show Comics',
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
