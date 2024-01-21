import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:weather_jano/services/api_services.dart';
import 'package:weather_jano/consts/strings.dart';
class MainController extends GetxController{

  @override
  void onInit() async
  {
    //getUserLocation();
    currentWeatherData=  getCurrentWeather(lattitude, longitude);
    hourlyWeatherData =   getHourlyWeather(lattitude, longitude);
    super.onInit();
  }
  var isDark = false.obs;
  var currentWeatherData;
  var hourlyWeatherData;
  // var latitude=0.0.obs;
  // var longitude=0.0.obs;

  changeTheme(){
    isDark.value=!isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  getUserLocation()async{
    var isLocationEnabled;
    var userPermission;
    isLocationEnabled =await Geolocator.isLocationServiceEnabled();

    if(!isLocationEnabled)
      {
        return Future.error("Location is not Enabled");
      }
    userPermission =await Geolocator.checkPermission();
    if(userPermission==LocationPermission.deniedForever)
      {
        return Future.error("Permisssion is Denied Forever");
      }
    else if(userPermission==LocationPermission.denied)
      {
         userPermission=await Geolocator.requestPermission();
         if(userPermission ==LocationPermission.denied)
           {
             return Future.error("Permission is Denied");
           }
      }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      // latitude.value=value.latitude;
      // longitude.value=value.longitude;
    });
  }
}