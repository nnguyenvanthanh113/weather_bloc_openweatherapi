import 'package:flutter/foundation.dart';
import 'package:weather_bloc_openweatherapi/exceptions/custom_error.dart';
import 'package:weather_bloc_openweatherapi/exceptions/exceptions.dart';
import 'package:weather_bloc_openweatherapi/models/weather.dart';
import 'package:weather_bloc_openweatherapi/services/weather_api_service.dart';
import 'dart:developer';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String cityName) async {
    try {
      final Weather weather = await weatherApiServices.getWeather(cityName);
      if (kDebugMode) {
        log('weather: ${weather.toMap()}');
      }
      final weatherMap = Weather.fromMap(weather.toMap());
      if (kDebugMode) {
        log(weatherMap.toString());
      }
      return weatherMap;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
