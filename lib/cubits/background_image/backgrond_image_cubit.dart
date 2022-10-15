import 'package:bloc/bloc.dart';
import 'package:weather_bloc_openweatherapi/cubits/background_image/background_images_state.dart';
import 'package:weather_bloc_openweatherapi/constants/constants.dart';

class BackgroundImageCubit extends Cubit<BackgroundImageState> {
  BackgroundImageCubit() : super(BackgroundImageState.initial());

  void analyzeWeather(double currentTemp) {
    if (currentTemp > Constants.kKelvinTemp) {
      emit(state.copyWith(isHot: true));
    } else {
      emit(state.copyWith(isHot: false));
    }
  }
}
