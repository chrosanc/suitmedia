import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'viewmodels/first_screen_viewmodel.dart';
import 'viewmodels/second_screen_viewmodel.dart';
import 'viewmodels/third_screen_viewmodel.dart';
import 'screens/first_screen.dart';
import 'screens/second_screen.dart';
import 'screens/third_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirstScreenViewModel()),
        ChangeNotifierProvider(create: (_) => SecondScreenViewModel()),
        ChangeNotifierProvider(create: (_) => ThirdScreenViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suitmedia Test',
      theme: ThemeData(
        actionIconTheme: ActionIconThemeData(
            backButtonIconBuilder: (BuildContext context) =>
                const Icon(IconlyLight.arrow_left_2)),
        appBarTheme: const AppBarTheme(
            shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            iconTheme: IconThemeData(color: Color(0xFF554AF0)),
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
            color: Colors.white,
            elevation: 0),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(),
      routes: {
        '/second': (context) => const SecondScreen(),
        '/third': (context) => const ThirdScreen(),
      },
    );
  }
}
