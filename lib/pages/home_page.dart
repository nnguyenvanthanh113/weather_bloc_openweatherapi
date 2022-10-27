import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_openweatherapi/cubits/background_image/background_image_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/background_image/background_images_state.dart';
import 'package:weather_bloc_openweatherapi/cubits/temp_settings/temp_setting.state.dart';
import 'package:weather_bloc_openweatherapi/cubits/temp_settings/temp_setting_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/text_theme/text_them_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/text_theme/text_theme_state.dart';
import 'package:weather_bloc_openweatherapi/cubits/weather/weather_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/weather/weather_state.dart';
import 'package:weather_bloc_openweatherapi/pages/setting_page.dart';
import 'package:weather_bloc_openweatherapi/pages/widget/create_router.dart';
import 'package:weather_bloc_openweatherapi/pages/widget/error_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => Temperature();
}

class Temperature extends State<HomePage> {
  String? _cityName;
  final TextEditingController _cityController = TextEditingController();
  @override
  void initState() {
    _fetchInitial();
    super.initState();
  }

  //get data
  Future<void> _fetchInitial() async {
    await context.read<WeatherCubit>().fetchWeather('Hà Nội');
  }

  //get color
  Color getTextColor() {
    final textTheme = context.watch<TextThemeCubit>().state.textTheme;

    if (textTheme == TextThemes.light) {
      return Colors.white;
    }
    return Colors.black;
  }

  //sow temperature
  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsCubit>().state.tempUnit;

    if (tempUnit == TempUnit.fahrenheit) {
      return '${((temperature - 273.15) * 1.8 + 32).toStringAsFixed(2)}℉';
    }
    return '${(temperature - 273.15).toStringAsFixed(2)}℃';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white70.withOpacity(0.85),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 70,
                          child: Divider(
                            thickness: 3.5,
                            color: Color(0xff6b9dfc),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _cityController,
                          autofocus: true,
                          decoration: InputDecoration(
                              prefixIcon: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<WeatherCubit>()
                                        .fetchWeather(_cityController.text);
                                    _cityController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  )),
                              suffixIcon: GestureDetector(
                                onTap: () => _cityController.clear(),
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                              hintText: "thành phố...",
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: ElevatedButton(
                              child: const Text('Search'),
                              onPressed: () {
                                context
                                    .read<WeatherCubit>()
                                    .fetchWeather(_cityController.text);
                                _cityController.clear();
                                Navigator.pop(context);
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
                size: 28,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text('Weather'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  createRoute(const SettingsPage()),
                );
              },
            ),
          ],
        ),
        body: BlocListener<WeatherCubit, WeatherState>(
          listener: (context, state) {
            context
                .read<BackgroundImageCubit>()
                .analyzeWeather(state.weather.temp!);
          },
          child: BlocBuilder<BackgroundImageCubit, BackgroundImageState>(
            builder: (context, state) {
              return Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: state.isHot == true
                              ? const AssetImage("assets/images/beach.jpg")
                              : const AssetImage("assets/images/sea.jpg"),
                          fit: BoxFit.cover)),
                  child: BlocConsumer<WeatherCubit, WeatherState>(
                    listener: (context, state) {
                      if (state.status == WeatherStatus.error) {
                        errorDialog(context, state.error.errMsg);
                      }
                    },
                    builder: (context, state) {
                      if (state.status == WeatherStatus.initial) {
                        return const Center(
                          child: Text('Please enter a city name',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                      if (state.status == WeatherStatus.loading) {
                        return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white));
                      }

                      if (state.weather.destination == '') {
                        return const Center(
                          child: Text('Please enter a city name',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                      return ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.weather.destination,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: getTextColor(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 60.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                showTemperature(state.weather.temp!),
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: getTextColor(),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Column(
                                children: [
                                  Text(
                                    '${showTemperature(state.weather.tempMax!)} (max)',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: getTextColor(),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    '${showTemperature(state.weather.tempMin!)} (min)',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: getTextColor(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 40.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              showIcon(state.weather.weatherStateIcon),
                              Text(
                                state.weather.weatherStateDescription,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: getTextColor(),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      );
                    },
                  ));
            },
          ),
        ));
  }
}

Widget showIcon(String icon) {
  return FadeInImage.assetNetwork(
    placeholder: 'assets/images/loading.gif',
    image: 'http://openweathermap.org/img/wn/$icon@2x.png',
    height: 100,
    width: 100,
  );
}
