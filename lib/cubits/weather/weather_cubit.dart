import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:weather_bloc_openweatherapi/cubits/weather/weather_state.dart';
import 'package:weather_bloc_openweatherapi/exceptions/custom_error.dart';
import 'package:weather_bloc_openweatherapi/repositories/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String cityName) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      await weatherRepository.fetchWeather(cityName).then((weather) {
        emit(state.copyWith(
          status: WeatherStatus.loaded,
          weather: weather,
        ));
      });
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: e,
      ));
    }
    log(state.toString());
  }
}
