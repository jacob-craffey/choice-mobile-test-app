import 'package:choice_sample_project/views/post_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
        title: 'Choice App',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                elevation: 0, backgroundColor: Colors.white, centerTitle: true),
            textTheme: GoogleFonts.ralewayTextTheme(textTheme).copyWith(
              headline2: GoogleFonts.raleway(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              headline1: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              bodyText1: GoogleFonts.raleway(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )),
        home: const PostList());
  }
}
