import 'package:exercise3/model/museum.dart';
import 'package:exercise3/screens/detail_screen.dart';
import 'package:exercise3/services/api_client.dart';
import 'package:flutter/material.dart';

class MuseumsScreen extends StatefulWidget {
  static const String id = 'museums_screen';

  @override
  MuseumsState createState() => MuseumsState();
}

class MuseumsState extends State<MuseumsScreen> {
  static final ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Museums'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<Museum>>(
              future: apiClient.getAllMuseums(1, 10),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final items = snapshot.data;
                  return Scrollbar(
                    child: RefreshIndicator(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return MuseumWidget(museum: items[index]);
                          },
                        ),
                        onRefresh: () {
                          return;
                        } // refreshList,
                        ),
                  );
                } // else
              } // builder
              )),
    );
  }
}

class MuseumWidget extends StatelessWidget {
  final Museum museum;

  MuseumWidget({
    Key key,
    @required this.museum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(museum: museum)),
        );
      },
      child: Container(
        color: Colors.white70,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                color: museum.read
                    ? Colors.transparent
                    : Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.9,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                museum.title,
                style: Theme.of(context).textTheme.headline1,
              ),
              Image.network(
                museum.image,
                fit: BoxFit.contain,
              ),
              Text(
                museum.address,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
