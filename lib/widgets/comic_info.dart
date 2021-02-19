import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:marvel/comic_info_sceen.dart';
import 'package:marvel/marvel.dart';

class ComicInfo extends StatelessWidget {
  int comicId;

  ComicInfo(this.comicId);
  Marvel _marvel = Marvel();

  String comicInfoData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _marvel.getComicInfoData(comicId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          comicInfoData = snapshot.data;
          return ComicInfoScreen(comicInfoData);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
// Image.network(
// _marvel.getImageUrl(comicInfoData, 0),
// fit: BoxFit.cover,
// colorBlendMode: BlendMode.colorBurn,
// height: double.infinity,
// width: double.infinity,
// alignment: Alignment.center,
// ),
