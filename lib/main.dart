import 'package:exercise3/screens/detail_screen.dart';
import 'package:exercise3/screens/map_screen.dart';
import 'package:exercise3/screens/menu_screen.dart';
import 'package:exercise3/screens/museus_screen.dart';
import 'package:exercise3/screens/splash_screen.dart';
import 'package:flutter/material.dart';

main() {
  runApp(RoutesApp());
}

class RoutesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen1.id,
      routes: {
        SplashScreen1.id: (context) => SplashScreen1(),
        MenuScreen.id: (context) => MenuScreen(),
        MapScreen.id: (context) => MapScreen(),
        MuseumsScreen.id: (context) => MuseumsScreen(),
        DetailScreen.id: (context) => DetailScreen(),
      },
      theme: ThemeData(
          primaryColor: Colors.blue[800],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.blue[200],
          textTheme: TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black87),
            headline2: TextStyle(fontSize: 13.0, color: Colors.grey),
            bodyText1: TextStyle(fontSize: 14.0, color: Colors.black87),
          )),
    );
  }
}
