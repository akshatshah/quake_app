import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
Map _data;

void main() async {
  _data = await getQuakes();

  runApp(new MaterialApp(
    title: 'Earthquakes',
    home: new Quakes(),
    debugShowCheckedModeBanner: false,
  ));
}

class Quakes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Earthquakes'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: new Center(
        child: new ListView.builder(
          itemCount: _data['features'].length,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return new Divider();
            final index = position ~/ 2;

            var format = new DateFormat.yMMMd().add_jm();
            var date = format.format(new DateTime.fromMicrosecondsSinceEpoch(_data['features'][index]['properties']['time']*1000,
            isUtc: true));
            return ListTile(
              title: Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Icon(Icons.access_time,
                      color: Colors.tealAccent.shade700,),
                    ),
                    new Text(
                      "$date",
                      style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.teal,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: new Container(
                child: new Row(
                    children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Icon(Icons.location_on,
                  color: Colors.tealAccent.shade700,),
                ),
                new Expanded(
                  child: new Text("${_data['features'][index]['properties']['place']}",
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.teal[300],
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],

            ),),
              leading: new CircleAvatar(
                backgroundColor: Colors.tealAccent,
                child: new Text(
                    "${_data['features'][index]['properties']['mag']}",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.teal[800],
                        fontWeight: FontWeight.w800
                      ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}

Future<Map> getQuakes() async {
  String apiUrl = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiUrl);

  return jsonDecode(response.body);
}