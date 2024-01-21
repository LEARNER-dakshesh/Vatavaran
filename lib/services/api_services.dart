// // TODO Implement this library.
// import 'package:http/http.dart' as http;
// import 'package:weather_jano/consts/strings.dart';
//
// import '../models/current_weather_model.dart';
//
// getCurrentWeather() async{
//
//   var link="https://api.openweathermap.org/data/2.5/weather?lat=$lattitude&lon=$longitude&appid$apiKey";
//   var res=await http.get (Uri.parse(link));
//   if(res.statusCode==200)
//   {
//     var data=currentWeatherDataFromJson(res.body.toString());
//     print("Data is recieved");
//     return data;
//   }
// }
//
import 'package:weather_jano/models/current_weather_model.dart';

import '../consts/strings.dart';
import 'package:http/http.dart' as http;

import '../models/hourly_weather_model.dart';

var link="https://api.openweathermap.org/data/2.5/weather?lat=$lattitude&lon=$longitude&appid=$apiKey&units=metric";
var hourlylink="https://api.openweathermap.org/data/2.5/forecast?lat=$lattitude&lon=$longitude&appid=$apiKey&units=metric";
// getCurrentWeather(lat, long) async {
//   var link = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
//   var res = await http.get(Uri.parse(link));
//   if (res.statusCode == 200) {
//     var data = currentWeatherDataFromJson(res.body.toString());
//
//     return data;
//   }
getCurrentWeather(lat, long) async {
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = currentWeatherDataFromJson(res.body.toString());
    return data;
  }
}
  getHourlyWeather(lat, long) async {

    var res = await http.get(Uri.parse(hourlylink));
    if (res.statusCode == 200) {
      var data = hourlyWeatherDataFromJson(res.body.toString());
      return data;
    }
}

