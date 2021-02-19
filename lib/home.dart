import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:marvel/character_screen.dart';
import 'marvel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Marvel _marvel = Marvel();

  int pageNo = 1;

  String allData;

  int characterCount = 10;

  int offsetValue = 10;

  void previousPage() {
    setState(() {
      offsetValue -= 10;
      pageNo--;
      print("new offset = $offsetValue");
    });
  }

  void nextPage() {
    setState(() {
      offsetValue += 10;
      pageNo++;
      print("new offset = $offsetValue");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                previousPage();
              },
              child: Icon(
                Icons.arrow_left,
                color: Colors.white,
                size: 60,
              ),
            ),
            Text(
              pageNo.toString() + ' - 140',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            GestureDetector(
              onTap: () {
                nextPage();
              },
              child: Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 60,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Marvel Characters', style: GoogleFonts.anton()),
      ),
      body: FutureBuilder(
        future: _marvel.getData(offsetValue),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            allData = snapshot.data;
            return ListView.builder(
              itemCount: characterCount,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterScreen(allData, index),
                      ),
                    );
                  },
                  child: ListTile(
                    focusColor: Colors.blue,
                    title: Text(
                      _marvel.getCharacterName(snapshot.data, index),
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(' '),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
