import 'dart:convert';

import 'package:weather_bloc_openweatherapi/constants/constants.dart';
import 'package:weather_bloc_openweatherapi/exceptions/exceptions.dart';
import 'package:weather_bloc_openweatherapi/models/weather.dart';
import 'package:http/http.dart' as http;

import 'http_error_handler.dart';

class WeatherApiServices {
  Future<Weather> getWeather(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: Constants.kHostApi,
      path: '/data/2.5/weather',
      queryParameters: {
        'q': city,
        'appid': Constants.kApiKey,
      },
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      } else {
        //log(response.body);
        late final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw WeatherException('Cannot get the weather of the city');
        }

        return Weather.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }
}
