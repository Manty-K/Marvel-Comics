import 'package:flutter/material.dart';
import 'package:marvel/widgets/comic_info.dart';
import 'marvel.dart';
import 'widgets/comic_card.dart';

class ComicScreen extends StatelessWidget {
  Marvel _marvel = Marvel();
  ScrollController _scrollController = ScrollController();
  int characterId;
  int availableComic;
  String characterName;
  ComicScreen(this.characterId, this.availableComic, this.characterName);
  String comicData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _marvel.getComicData(characterId, availableComic),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            comicData = snapshot.data;
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
                      comicName: _marvel.getComicTitle(comicData, index),
                      comicDescription:
                          _marvel.getComicDescription(comicData, index),
                      url: _marvel.getComicImageURL(comicData, index),
                      openComic: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComicInfo(_marvel
                                .getComicIDFromCharacter(comicData, index)),
                          ),
                        );
                      },
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
