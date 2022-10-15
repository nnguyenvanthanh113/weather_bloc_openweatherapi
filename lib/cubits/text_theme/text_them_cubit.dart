import 'package:bloc/bloc.dart';
import 'package:weather_bloc_openweatherapi/cubits/text_theme/text_theme_state.dart';

class TextThemeCubit extends Cubit<TextThemeState> {
  TextThemeCubit() : super(TextThemeState.initial());

  void changeTextTheme() {
    emit(state.copyWith(
      textTheme: state.textTheme == TextThemes.dark
          ? TextThemes.light
          : TextThemes.dark,
    ));
  }
}
