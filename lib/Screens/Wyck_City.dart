import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:wyck/Screens/Wyck_Home.dart';
import 'SizeConfig.dart';

class SearchWyck extends StatefulWidget {
  String cityName;
  SearchWyck({this.cityName});
  @override
  _SearchWyckState createState() => _SearchWyckState();
}

class _SearchWyckState extends State<SearchWyck> {
  static var now = new DateTime.now();
  var hour = now.hour;
  var temp,
      wind_speed,
      humidity,
      feelslike,
      cloud;
  final api = "API_KEY";

  getLocation() async {
    final data = await getLocationData();
    if (data != null) {
      cloud = data["weather"][0]["main"];
      temp = data["main"]["temp"];
      wind_speed = data["wind"]["speed"].toString();
      feelslike = data['main']["feels_like"];
      humidity = data['main']["humidity"];
      setState(() {});
    } else {
      final snackBar = SnackBar(
        content: Text(
          'No Data Found',
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3.5),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      );
      scaffold_state.currentState.showSnackBar(snackBar);

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }

  Future getLocationData() async {
    final url =
        "http://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&appid=$api&units=metric";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonLocation = jsonDecode(response.body);
      return jsonLocation;
    }
  }

  GlobalKey<ScaffoldState> scaffold_state = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  Future<bool> _onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WyckHome()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          key: scaffold_state,
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: hour < 12
                          ? AssetImage("images/1.jpg")
                          : hour < 19
                              ? AssetImage("images/2.jpg")
                              : AssetImage("images/3.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 3.5,
                      ),
                      Center(
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: hour < 12
                                  ? BoxedIcon(
                                      WeatherIcons.cloud,
                                      size: SizeConfig.blockSizeVertical * 18,
                                      color: Colors.white,
                                    )
                                  : hour < 19
                                      ? BoxedIcon(
                                          WeatherIcons.day_sunny,
                                          size: SizeConfig.blockSizeVertical * 17,
                                          color: Colors.black,
                                        )
                                      : BoxedIcon(
                                          WeatherIcons
                                              .moon_alt_waxing_crescent_3,
                                          size: SizeConfig.blockSizeVertical * 20,
                                          color: Colors.white,
                                        ))),
                      Center(child: Text("${widget.cityName.toUpperCase()}",style: GoogleFonts.ubuntu(fontSize: 30,
                          color: hour < 12
                              ? Colors.white
                              : hour < 19 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold),),),
                      SizedBox(height: SizeConfig.blockSizeVertical*3,),
                      Card(
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  temp != null ? "${temp.toString()}°" : "",
                                  style: GoogleFonts.ubuntu(
                                      fontSize: SizeConfig.blockSizeHorizontal * 16,
                                      color: hour < 12
                                          ? Colors.white
                                          : hour < 19 ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 3.5,
                              ),
                              if (temp != null)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: SizeConfig.blockSizeVertical * 6,
                                            width: SizeConfig.blockSizeHorizontal * 45,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                BoxedIcon(WeatherIcons.wind_deg_45,
                                                    size: SizeConfig.blockSizeVertical * 5,
                                                    color: hour < 12
                                                        ? Colors.white
                                                        : hour < 19
                                                        ? Colors.black
                                                        : Colors.white),
                                                SizedBox(
                                                    width:
                                                    SizeConfig.blockSizeHorizontal *
                                                        1),
                                                Center(
                                                    child: Text(
                                                      "${wind_speed.toString()}",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                              6,
                                                          fontWeight: FontWeight.w900,
                                                          color: hour < 12
                                                              ? Colors.white
                                                              : hour < 19
                                                              ? Colors.black
                                                              : Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: SizeConfig.blockSizeVertical * 6,
                                            width: SizeConfig.blockSizeHorizontal * 43,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                BoxedIcon(WeatherIcons.humidity,
                                                    size: SizeConfig.blockSizeVertical * 5,
                                                    color: hour < 12
                                                        ? Colors.white
                                                        : hour < 19
                                                        ? Colors.black
                                                        : Colors.white),
                                                SizedBox(
                                                    width:
                                                    SizeConfig.blockSizeHorizontal *
                                                        1.5),
                                                Text(
                                                  "$humidity",
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                          5,
                                                      fontWeight: FontWeight.w900,
                                                      color: hour < 12
                                                          ? Colors.white
                                                          : hour < 19
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeHorizontal * 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: SizeConfig.blockSizeVertical * 6,
                                            width: SizeConfig.blockSizeHorizontal * 43,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.wb_sunny,
                                                    size: SizeConfig.blockSizeVertical * 5,
                                                    color: hour < 12
                                                        ? Colors.white
                                                        : hour < 19
                                                        ? Colors.black
                                                        : Colors.white),
                                                SizedBox(
                                                  width:
                                                  SizeConfig.blockSizeHorizontal *
                                                      1.5,
                                                ),
                                                Text(
                                                  "$feelslike",
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                          5,
                                                      fontWeight: FontWeight.w900,
                                                      color: hour < 12
                                                          ? Colors.white
                                                          : hour < 19
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: SizeConfig.blockSizeVertical * 6,
                                            width: SizeConfig.blockSizeHorizontal * 50,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                BoxedIcon(WeatherIcons.cloud,
                                                    size: SizeConfig.blockSizeVertical * 5,
                                                    color: hour < 12
                                                        ? Colors.white
                                                        : hour < 19
                                                        ? Colors.black
                                                        : Colors.white),
                                                SizedBox(
                                                    width:
                                                    SizeConfig.blockSizeHorizontal *
                                                        1.5),
                                                Text(
                                                  "$cloud",
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                          4,
                                                      fontWeight: FontWeight.w900,
                                                      color: hour < 12
                                                          ? Colors.white
                                                          : hour < 19
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical*3,
                                    ),
                                  ],
                                )
                              else
                                Center(
                                    child: SpinKitChasingDots(
                                      color: Colors.white,
                                    )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
