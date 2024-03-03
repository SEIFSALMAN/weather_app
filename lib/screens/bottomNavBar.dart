import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/screens/settings_screen.dart';
import '../model/weather_model.dart';

class NavBar extends StatefulWidget {

  List<WeatherModel> weatherModel = [];
  NavBar({required this.weatherModel});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  List pages = [];

  @override
  void initState() {
    pages = [
      HomeScreen(weatherModel: widget.weatherModel),
      SearchScreen(weatherModel: widget.weatherModel),
      ForecastScreen(weatherModel: widget.weatherModel),
      SettingsScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff060720),
          elevation: 0,
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (value)=> setState(() {
            _currentIndex = value;
          }),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset("assets/icons/1.2.png",height: height * 0.04,color: Colors.grey.withOpacity(0.5)),
              label: '',
              activeIcon: Image.asset("assets/icons/1.1.png",height: height * 0.04,color: Colors.white)
            ),
            BottomNavigationBarItem(
                icon: Image.asset("assets/icons/2.2.png",height: height * 0.04,color: Colors.grey.withOpacity(0.5)),
              label: '',
              activeIcon: Image.asset("assets/icons/2.1.png",height: height * 0.04,color: Colors.white)
            ),
            BottomNavigationBarItem(
                icon: Image.asset("assets/icons/3.2.png",height: height * 0.04,color: Colors.grey.withOpacity(0.5)),
              label: '',
              activeIcon: Image.asset("assets/icons/3.1.png",height: height * 0.04,color: Colors.white)
            ),
            BottomNavigationBarItem(
                icon: Image.asset("assets/icons/4.2.png",height: height * 0.04,color: Colors.grey.withOpacity(0.5)),
              label: '',
              activeIcon: Image.asset("assets/icons/4.1.png",height: height * 0.04,color: Colors.white)
            ),
          ],
        ),

      ),
    );
  }
}

