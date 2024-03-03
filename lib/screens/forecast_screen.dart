import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:weather_app/components/weekly_weather_widget.dart';
import '../model/weather_model.dart';
import '../utils/static_file.dart';

class ForecastScreen extends StatefulWidget {
  List<WeatherModel> weatherModel = [];
  ForecastScreen({required this.weatherModel});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
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
                height: height * 0.03,
              ),
              Text("Forecast Report",style: TextStyle(color: Colors.white,fontSize: 25),),
              SizedBox(height: height * 0.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 23)),
                    Text(DateFormat('yMEd').format(DateTime.now()),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 17))
                  ],
                ),
              ),
              SizedBox(height: height * 0.02,),
              Container(
                height: height * 0.17,
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
              ),
              SizedBox(height: height * 0.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Next Forecast",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 23)),
                    Image.asset("assets/icons/5.png",height: height * 0.03,color: Colors.white.withOpacity(0.6),)
                    // Text(DateFormat('yMEd').format(DateTime.now().add(Duration(days: 1))),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 17))
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(

                      itemCount: widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather!.length,
                      itemBuilder: (context,index) => WeeklyWeatherWidget(item: widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![index])
                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}

