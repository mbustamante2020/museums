import 'package:exercise3/screens/menu_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreen1 extends StatefulWidget {
  static const String id = 'splash_screen1';

  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<SplashScreen1> {
  // Se inicializa FlutterFire
  void initializeFlutterFire() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      print("ok");
    } catch (e) {
      print("error ${e.toString()}");
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: MenuScreen(),
        title: Text(
          'Welcome to Museums',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
        image: Image(
            image: AssetImage('lib/assets/images/background.png'),
            width: 400.0),
        backgroundColor: Theme.of(context).backgroundColor,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 140.0,
        loaderColor: Colors.black87);
  }
}
