import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;

void main() async {

  List _data = await getQuakes();

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
    );
  }

}

Future<List> getQuakes() async {
  String apiUrl ='https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response =await http.get(apiUrl);

  return jsonDecode(response.body);
}