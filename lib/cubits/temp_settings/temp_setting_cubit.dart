import 'package:bloc/bloc.dart';
import 'package:weather_bloc_openweatherapi/cubits/temp_settings/temp_setting.state.dart';

class TempSettingsCubit extends Cubit<TempSettingState> {
  TempSettingsCubit() : super(TempSettingState.initial());
  void toggleTempUnit() {
    emit(state.copyWith(
      tempUnit: state.tempUnit == TempUnit.Celsius
          ? TempUnit.Fahrenheit
          : TempUnit.Celsius,
    ));
  }
}
