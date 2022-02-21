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
                fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
            headline1: GoogleFonts.raleway(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            bodyText1: GoogleFonts.raleway(
                fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black,
            secondary: Color.fromARGB(31, 0, 0, 0),
            tertiary: Color.fromARGB(255, 5, 0, 255),
            background: Colors.white,
            error: Colors.red,
            onBackground: Colors.black,
            onError: Colors.black,
            onPrimary: Color.fromARGB(31, 0, 0, 0),
            onSecondary: Colors.black,
            onSurface: Colors.black,
            surface: Colors.white,
          ),
        ),
        home: const PostList());
  }
}
