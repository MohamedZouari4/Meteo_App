import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class MeteoDetailsPage extends StatefulWidget {
  String city = "";
  MeteoDetailsPage(this.city);
  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}
class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;
  void initState() {
    super.initState();
    geMeteotData(widget.city);
  }
  void geMeteotData(String city) {
    print("Météo de la ville de " + city);
    String url =

        "https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=c109c07bc4df77a88c923e6407aef864";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.meteoData = json.decode(resp.body);
        print(this.meteoData);
      });
    }).catchError((err) {
      print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Données Meteo de ${widget.city}')),
        body: meteoData == null ? Center(
          child: CircularProgressIndicator(),)
            : ListView.builder(
        itemCount: (meteoData == null ? 0 : meteoData['list'].length),
    itemBuilder: (context, index) {
    return Card(
    child: Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [Colors.blue, Colors.transparent])),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Row(
    children: [
    //Ce widget sera développé dans la question 8
    CircleAvatar(
    backgroundImage: AssetImage(

    "images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"),
    ),
    Padding(
    padding: EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    //Ce widget sera développé dans la question 9
    Text(
    "${new DateFormat('Edd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt'] * 1000000))}",
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold),
    ),
    //Ce widget sera développé dans la question 10
    Text(
    "${new
    DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt'] *
    1000000))}"
    " | ${meteoData['list'][index]['weather'][0]['main']}",
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold),
    )
    ],
    ),
    ),
    ],
    ),
    //Ce widget sera développé dans la question 11
      Text(
        "${(meteoData['list'][index]['main']['temp'] - 273.15).round()} °C",
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold),
      )
    ],
    ),
    ),
    );
    }));
  }
}