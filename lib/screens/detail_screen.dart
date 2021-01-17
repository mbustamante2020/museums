import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise3/model/museum.dart';
import 'package:exercise3/services/firestore_client.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static const String id = 'detail_screen';
  final Museum museum;

  DetailScreen({
    @optionalTypeArgs this.museum,
  });

  _AppState createState() => _AppState(museum: museum);
}

class _AppState extends State<DetailScreen> {
  Museum museum;
  static final FirestoreClient firestoreClient = FirestoreClient();
  TextEditingController nameController = TextEditingController();

  _AppState({
    @optionalTypeArgs this.museum,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          museum.title,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('${museum.title}',
                    style: Theme.of(context).textTheme.bodyText1),
                Image.network(
                  museum.image,
                  fit: BoxFit.contain,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text("${museum.description}",
                    style: Theme.of(context).textTheme.bodyText1),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text("Address: ${museum.address}",
                    style: Theme.of(context).textTheme.bodyText1),
                Text("Phone: ${museum.phone}",
                    style: Theme.of(context).textTheme.bodyText1),
                Text("Email: ${museum.email}",
                    style: Theme.of(context).textTheme.bodyText1),
                Text("Location: ${museum.lat}  ${museum.lon}  ",
                    style: Theme.of(context).textTheme.bodyText1),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 55.0,
                    child: RaisedButton(
                      child: Icon(
                        Icons.send,
                        color: Colors.blue,
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          firestoreClient.addNote(
                              museum.id, nameController.text);
                          nameController.text = "";
                        });
                      },
                    ),
                  ),
                ]),
                readNotes(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget readNotes() {
    return StreamBuilder(
      stream: firestoreClient.getNotes(museum.id),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          shrinkWrap: true,
          children: snapshot.data.docs.map((document) {
            return Expanded(
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Text(
                      '${document['note'].toString()}',
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.0,
                  height: 55.0,
                  child: RaisedButton(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        firestoreClient.deleteNote(document.id);
                      });
                    },
                  ),
                ),
              ]),
            );
          }).toList(),
        );
      },
    );
  }
}
