import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../model/weather_model.dart';
import '../utils/static_file.dart';

class SearchScreen extends StatefulWidget {
  List<WeatherModel> weatherModel = [];

  SearchScreen({super.key, required this.weatherModel});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff060720),
        body: SizedBox(
            height: myHeight,
            width: myWidth,
            child: Column(
              children: [
                SizedBox(
                  height: myHeight * 0.03,
                ),
                Text(
                  'Pick location',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: myHeight * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find the area or city that you want to know',
                        style: TextStyle(
                            fontSize: 16, color: Colors.white.withOpacity(0.8)),
                      ),
                      Text(
                        'The detailed weather info at this time',
                        style: TextStyle(
                            fontSize: 15, color: Colors.white.withOpacity(0.4)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: myHeight * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.06),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.05)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: myWidth * 0.05),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Image.asset(
                                    'assets/icons/2.2.png',
                                    height: myHeight * 0.025,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: myWidth * 0.03,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // height: myHeight * 0.1,
                          // width: myWidth * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.05)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: myHeight * 0.019),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/6.png',
                                  height: myHeight * 0.03,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: myHeight * 0.04,
                ),
                Expanded(
                    child: GridView.custom(
                        padding:
                            EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                        gridDelegate: SliverStairedGridDelegate(
                            mainAxisSpacing: 13,
                            startCrossAxisDirectionReversed: false,
                            pattern: [
                              StairedGridTile(0.5, 2 / 2.1),
                              StairedGridTile(0.5, 2 / 2.1),
                            ]),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: widget.weatherModel.length,
                          (context, index) {
                            print(widget.weatherModel[index].name.toString());
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: myWidth * 0.02),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: StaticFile.myLocation ==
                                            widget.weatherModel[index].name
                                                .toString()
                                        ? null
                                        : Colors.white.withOpacity(0.05),
                                    gradient: StaticFile.myLocation ==
                                            widget.weatherModel[index].name
                                                .toString()
                                        ? LinearGradient(colors: [
                                            Color.fromARGB(255, 21, 85, 169),
                                            Color.fromARGB(255, 44, 162, 246),
                                          ])
                                        : null,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget
                                                    .weatherModel[index]
                                                    .weeklyWeather![index]!
                                                    .mainTemp
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                weatherState[index].toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white
                                                        .withOpacity(0.5)),
                                              )
                                            ],
                                          ),
                                          Image.asset(
                                            widget.weatherModel[index]
                                                .weeklyWeather![index]!.mainImg
                                                .toString(),
                                            height: myHeight * 0.06,
                                            width: myWidth * 0.15,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.weatherModel[index].name
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )))
              ],
            )),
      ),
    );
  }

  List<String> weatherState = [
    "Rainy",
    "Rainy",
    "Rainy",
    "Cloudy",
    "Sunny",
    "Sunny",
  ];
}
