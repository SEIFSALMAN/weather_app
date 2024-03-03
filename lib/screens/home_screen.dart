import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:weather_app/utils/static_file.dart';
import '../model/weather_model.dart';

class HomeScreen extends StatefulWidget {
  List<WeatherModel> weatherModel = [];
  HomeScreen({required this.weatherModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await scrollToIndex();
    });
    findMyLocationIndex();
    super.initState();
  }

  findMyLocationIndex() {
    for (var i = 0; i < widget.weatherModel.length; i++) {
      if (widget.weatherModel[i].name == StaticFile.myLocation) {
        setState(() {
          StaticFile.myLocationIndex = i;
          complete1 = true;
        });
        break;
      }
    }
    findHourIndex();
  }

  DateTime time = DateTime.now();
  int hourIndex = 0;
  bool complete1 = false;
  bool complete2 = false;

  findHourIndex() {
    String myTime;
    myTime = time.hour.toString();
    if(myTime.length == 1){
      myTime = '0$myTime';
    }
    for (var i = 0;
        i <
            widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
                .allTime!.hour!.length;
        i++) {
      if (widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
              .allTime!.hour![i]!
              .substring(0, 2)
              .toString() ==
          myTime) {
        setState(() {
          hourIndex = i;
          complete2 = true;
        });
        break;
      }
    }
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  scrollToIndex() async {
    itemScrollController.scrollTo(
        index: hourIndex,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic);
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
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                  widget.weatherModel[StaticFile.myLocationIndex].name
                      .toString(),
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                DateFormat('yMEd').format(DateTime.now()).toString(),
                style: TextStyle(
                    fontSize: 17, color: Colors.white.withOpacity(0.5)),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              Container(
                height: height * 0.05,
                width: width * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 21, 85, 169),
                              Color.fromARGB(255, 44, 162, 246)
                            ])),
                        child: Center(
                            child: Text("Forecast",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white))),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Center(
                            child: Text("Air quality",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(0.5)))),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Image.asset(
                widget.weatherModel[StaticFile.myLocationIndex]
                    .weeklyWeather![0]!.mainImg
                    .toString(),
                height: height * 0.25,
                width: width * 0.8,
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Container(
                height: height * 0.08,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              "Temp",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 20),
                            ),
                            Text(
                              widget.weatherModel[StaticFile.myLocationIndex]
                                  .weeklyWeather![0]!.mainTemp
                                  .toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              "Wind",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 20),
                            ),
                            Text(
                              widget.weatherModel[StaticFile.myLocationIndex]
                                  .weeklyWeather![0]!.mainWind
                                  .toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        )),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "Humidity",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 20),
                          ),
                          Text(
                            widget.weatherModel[StaticFile.myLocationIndex]
                                .weeklyWeather![0]!.mainHumidity
                                .toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                    Text("View full Report",
                        style: TextStyle(color: Colors.blue, fontSize: 14))
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,bottom: 4),
                  child: ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.weatherModel[StaticFile.myLocationIndex]
                          .weeklyWeather![0]!.allTime!.hour!.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 15),
                            child: Container(
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  color: hourIndex == index ? null : Colors.white.withOpacity(0.3),
                                  gradient: hourIndex == index ?
                              LinearGradient(colors: [
                              Color.fromARGB(255, 21, 85, 169),
                                Color.fromARGB(255, 44, 162, 246)
                                ]) : null
                                  ,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    widget
                                        .weatherModel[StaticFile.myLocationIndex]
                                        .weeklyWeather![0]!
                                        .allTime!
                                        .img![index]
                                        .toString(),
                                    height: height * 0.04,
                                  ),
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget
                                            .weatherModel[
                                                StaticFile.myLocationIndex]
                                            .weeklyWeather![0]!
                                            .allTime!
                                            .hour![index]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Text(
                                        widget
                                            .weatherModel[
                                                StaticFile.myLocationIndex]
                                            .weeklyWeather![0]!
                                            .allTime!
                                            .temps![index]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
