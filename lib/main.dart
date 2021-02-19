import 'dart:convert';

import 'package:flutter/material.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:marvel/character_screen.dart';
import 'marvel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffF0131E),
        scaffoldBackgroundColor: Colors.black,
        accentColor: Color(0xffF0131E),
      ),
      home: Home(),
    );
  }
}
