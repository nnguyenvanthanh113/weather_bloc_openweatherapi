import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_openweatherapi/cubits/background_image/backgrond_image_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/temp_settings/temp_setting_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/text_theme/text_them_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/weather/weather_cubit.dart';
import 'package:weather_bloc_openweatherapi/pages/home_page.dart';

import 'repositories/weather_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => WeatherCubit(
                    weatherRepository: context.read<WeatherRepository>(),
                  )),
          BlocProvider<TempSettingsCubit>(
            create: (context) => TempSettingsCubit(),
          ),
          BlocProvider<BackgroundImageCubit>(
            create: (context) => BackgroundImageCubit(),
          ),
          BlocProvider<TextThemeCubit>(
            create: (context) => TextThemeCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Weather Apps',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
