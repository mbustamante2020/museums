import 'package:exercise3/screens/map_screen.dart';
import 'package:exercise3/screens/museus_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  static const String id = 'menu_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Museums'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Museums in Catalonia',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87),
            ),
            SizedBox(height: 20.0),
            Image(
                image: AssetImage('lib/assets/images/background.png'),
                height: 200.0),
            SizedBox(height: 20.0),
            Center(
              widthFactor: 100,
              child: Row(children: <Widget>[
                RaisedButton(
                  child: Icon(
                    Icons.museum,
                    color: Colors.blue,
                    size: MediaQuery.of(context).size.width * 0.3,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MuseumsScreen.id);
                  },
                ),
                SizedBox(width: 20.0),
                RaisedButton(
                  child: Icon(
                    Icons.map,
                    color: Colors.blue,
                    size: MediaQuery.of(context).size.width * 0.3,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MapScreen.id);
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
