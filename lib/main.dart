import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';
import 'package:weather_app/views/additional_info.dart';
import 'package:weather_app/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  // @override
  // void initState() {
  //   super.initState();
  //   client.getCurrentWeather("Georgia");
  // }
  Future<void> getData() async{
     data = await client.getCurrentWeather("Lagos");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        elevation: 0,
        title: Text(
          'Weather App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          currentWeather(Icons.wb_sunny_rounded, "${data!.temp}°", "${data!.cityName}"),
          const SizedBox(height: 20,),
          const Text('Additional Info',
          style: TextStyle(fontSize: 24, color: Color(0xdd212121),
          fontWeight: FontWeight.bold
          ),
          ),
          const Divider(),
          const SizedBox(height: 20.0,),
          additionalInfo("${data!.wind}", "${data!.humidity}", "${data!.pressure}", "${data!.feel_like}")
        ],
      );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return Container();
        },
      )
    );
  }
}
