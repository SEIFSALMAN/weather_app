import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';

class WeeklyWeatherWidget extends StatelessWidget {
  WeeklyWeather? item;

  WeeklyWeatherWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Container(
        height: height * 0.1,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item!.day.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                Text(
                  DateFormat('yMd')
                      .format(DateTime.now().add(Duration(days: 1))),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 15),
                )
              ],
            ),
            SizedBox(
              width: width * 0.1,
            ),
            Text(
              item!.mainTemp.toString(),
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Image.asset(
              item!.mainImg.toString(),
              height: height * 0.06,
              width: width * 0.15,
            )
          ],
        ),
      ),
    );
  }
}
