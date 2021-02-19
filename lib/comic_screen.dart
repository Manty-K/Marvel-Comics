import 'package:flutter/material.dart';
import 'marvel.dart';
import 'widgets/comic_card.dart';

class ComicScreen extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  int characterId;
  int availableComic;
  String characterName;
  ComicScreen(this.characterId, this.availableComic, this.characterName);
  String comicData;

  Marvel _marvel = Marvel();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _marvel.getComicData(characterId, availableComic),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            comicData = snapshot.data;
            print(comicData);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(characterName + ' in Comics'),
              ),
              body: Scrollbar(
                controller: _scrollController,
                isAlwaysShown: false,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: availableComic,
                  itemBuilder: (context, index) {
                    return ComicCard(
                      _marvel.getComicTitle(comicData, index),
                      _marvel.getComicDescription(comicData, index),
                      _marvel.getComicImageURL(comicData, index),
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

/*
ListTile(
                    title: Text(
                      _marvel.getComicTitle(comicData, index),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
 */
