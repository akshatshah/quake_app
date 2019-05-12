import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;

Map _data;

void main() async {

  _data = await getQuakes();
  print(_data['features'][0]['properties']);

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
            itemBuilder: (BuildContext context, int position){
              if(position.isOdd) return new Divider();
              return ListTile(
                title: new Text("${_data['features'][position]['properties']['place']}"),
              );
            },
        ),
      ),
    );
  }

}

Future<Map> getQuakes() async {
  String apiUrl ='https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response =await http.get(apiUrl);

  return jsonDecode(response.body);
}