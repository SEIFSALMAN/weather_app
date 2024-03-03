import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/screens/bottomNavBar.dart';
import '../model/weather_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await loadJson();
    });
    super.initState();
  }
  List data =[];
  List<WeatherModel> weatherList = [];

  loadJson() async {
    String myData = await rootBundle.loadString("assets/myJson/file.json");


    setState(() {
      data = json.decode(myData);
      weatherList = data.map((e) => WeatherModel.fromJson(e)).toList();
    });

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => NavBar(weatherModel: weatherList,)));
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff060720),
        body: Container(
          height: height,
          width: width,
          child: Center( child: Text("Weather")),
        ),
      ),
    );
  }
}

