// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_this

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(List<String> args) {
  runApp(const MaterialApp(
    title: "Weather App",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: prefer_typing_uninitialized_variables
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  Future getWeather() async {
    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=-7.933358&lon=112.610397&units=imperial&appid=4935ce7be16086796e29ec43d46fd4c6"));
    var results = jsonDecode(response.body);
    print(results);
    setState(() {
      this.temp = ((results['main']['temp'] - 32) * 5 / 9).toStringAsFixed(2);
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['main']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Malang",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
               Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.thermometerHalf),
                        title: const Text("Temperature"),
                        trailing: Text(temp != null
                            ? temp.toString() + "\u00B0"
                            : "Loading"),
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.cloud),
                        title: const Text("Weather"),
                        trailing: Text(description != null
                            ? description.toString()
                            : "Loading"),
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.sun),
                        title: const Text("Humidity"),
                        trailing: Text(humidity != null
                            ? humidity.toString() + "\u00B0"
                            : "Loading"),
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.wind),
                        title: const Text("Wind Speed"),
                        trailing: Text(windSpeed != null
                            ? windSpeed.toString() + "\u00B0"
                            : "Loading"),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
