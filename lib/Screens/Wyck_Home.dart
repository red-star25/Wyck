import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'Wyck_City.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:wyck/Screens/SizeConfig.dart';
import 'package:sunrise_sunset/sunrise_sunset.dart';


const String testDevice='';

class WyckHome extends StatefulWidget {
  @override
  _WyckHomeState createState() => _WyckHomeState();
}

class _WyckHomeState extends State<WyckHome> {



  static var now = new DateTime.now();
  var hour = now.hour;
  var temp, wind_speed, lat, long, city, sunset, sunrise, cloud,vision;
  final api = "API_KEY";

  Future getLocationData() async {
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    lat = position.latitude;
    long = position.longitude;
    final sun = await SunriseSunset.getResults(
        date: DateTime.now(), latitude: lat, longitude: long);
    final url =
        "https://api.weatherbit.io/v2.0/current?&lat=$lat&lon=$long&key=$api";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonLocation = jsonDecode(response.body);
      final data = jsonLocation;
      city = data["data"][0]["city_name"];
      cloud = data["data"][0]["weather"]["description"];
      temp = data["data"][0]["temp"];
      wind_speed = data["data"][0]["wind_spd"].toString();
      sunrise =
          sun.data.sunrise.toLocal().toString().split(" ")[1].split(".")[0];
      sunset = sun.data.sunset.toLocal().toString().split(" ")[1].split(".")[0];
      vision = data["data"][0]["vis"];
    } else {
      return CircularProgressIndicator();
    }
    setState(() {});
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  Future<bool> _onBackPressed() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal*3.5,
                  ),
                  Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: hour < 12
                              ? BoxedIcon(
                                  WeatherIcons.cloud,
                            size: SizeConfig.blockSizeHorizontal*29,
                                  color: Colors.white,
                                )
                              : hour < 19
                                  ? BoxedIcon(
                                      WeatherIcons.day_sunny,
                                      size: SizeConfig.blockSizeHorizontal*29,
                                      color: Colors.black,
                                    )
                                  : BoxedIcon(
                                      WeatherIcons.moon_alt_waxing_crescent_3,
                                      size: SizeConfig.blockSizeHorizontal*35,
                                      color: Colors.white,
                                    ))),
                  SizedBox(height: SizeConfig.blockSizeVertical*5,),
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
                          if (city != null)
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
                                                child: Row(
                                                  children: <Widget>[

                                                    Text(
                                                      "${wind_speed.toString().substring(0,1)}",
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
                                                    ),
                                                    Text(
                                                      " mp/h",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                              3,
                                                          fontWeight: FontWeight.w900,
                                                          color: hour < 12
                                                              ? Colors.white
                                                              : hour < 19
                                                              ? Colors.black
                                                              : Colors.white),
                                                    ),
                                                  ],
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
                                            BoxedIcon(WeatherIcons.sunrise,
                                                size:SizeConfig.blockSizeVertical * 5,
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
                                              "$sunrise",
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
                                            BoxedIcon(WeatherIcons.sunset,
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
                                              "$sunset",
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.remove_red_eye,size: 30,color: hour < 12
                                        ? Colors.white
                                        : hour < 19
                                        ? Colors.black
                                        : Colors.white),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal*3,
                                    ),
                                    Text(
                                      "${vision.toString()}",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.ubuntu(
                                          fontSize: SizeConfig
                                              .blockSizeHorizontal *
                                              5.5,
                                          fontWeight: FontWeight.w900,
                                          color: hour < 12
                                              ? Colors.white
                                              : hour < 19
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ],
                                )
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  onSubmitted: (value) {
                    value != ""
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchWyck(cityName: value)))
                        : "";
                  },
                  style: GoogleFonts.russoOne(
                      color: Colors.red,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.red),
                      hintText: "Search Places",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
