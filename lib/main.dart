import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String apiKey = '4dcd380a99018a6d9f08ce499772837e';
  String city = 'Kota Tangerang';
  String weather = '';
  String temperature = '';
  String formattedDate = '';
  String day = '';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');
    final response = await http.get(url);
    final data = json.decode(response.body);
    final mainWeather = data['weather'][0]['main'];
    final temp = data['main']['temp'];
    final tempInCelsius = (temp - 273.15).toStringAsFixed(1);
    final date = DateTime.now();
    final formatted = DateFormat.yMMMMd().format(date);
    final dayOfWeek = DateFormat.E().format(date);

    setState(() {
      weather = mainWeather;
      temperature = tempInCelsius;
      formattedDate = formatted;
      day = dayOfWeek;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'data:image/jpeg;base64,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'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                city,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$day, $formattedDate',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '$temperature °c',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '---------------',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$weather',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '23°c / 27°c',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
