import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:weather_bloc_openweatherapi/cubits/temp_settings/temp_setting.state.dart';
import 'package:weather_bloc_openweatherapi/cubits/temp_settings/temp_setting_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/text_theme/text_them_cubit.dart';
import 'package:weather_bloc_openweatherapi/cubits/text_theme/text_theme_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                  'Temperature Unit: ${context.watch<TempSettingsCubit>().state.enumToString()}'),
              subtitle: const Text('Celsius/Fahrenheit (Default: Celsius)'),
              trailing: Switch(
                value: context.watch<TempSettingsCubit>().state.tempUnit ==
                    TempUnit.celsius,
                onChanged: (_) {
                  context.read<TempSettingsCubit>().toggleTempUnit();
                },
              ),
            ),
            const SizedBox(height: 20),
            // ListTile(
            //   title: Text(
            //       'Text Theme: ${context.watch<TextThemeCubit>().state.enumToString()}'),
            //   subtitle: const Text('Light/Dark (Default: Light)'),
            //   trailing: Switch(
            //     value: context.watch<TextThemeCubit>().state.textTheme ==
            //         TextThemes.light,
            //     onChanged: (_) {
            //       context.read<TextThemeCubit>().changeTextTheme();
            //     },
            //   ),
            // ),
            // const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 18.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        'Text Theme: ${context.watch<TextThemeCubit>().state.enumToString()}'),
                    FlutterSwitch(
                      width: 50.0,
                      height: 25.0,
                      toggleSize: 25.0,
                      borderRadius: 20.0,
                      padding: 0.0,
                      activeToggleColor: const Color(0xFF6E40C9),
                      inactiveToggleColor: const Color(0xFF2F363D),
                      activeSwitchBorder: Border.all(
                        color: const Color(0xFFD1D5DA),
                        width: 1.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: const Color(0xFFD1D5DA),
                        width: 1.0,
                      ),
                      activeColor: Color.fromARGB(255, 91, 154, 243),
                      inactiveColor: Colors.white,
                      activeIcon: const Icon(
                        Icons.wb_sunny,
                        color: Color(0xFFF8E3A1),
                      ),
                      inactiveIcon: const Icon(
                        Icons.nightlight_round,
                        color: Color(0xFFFFDF5D),
                      ),
                      value: context.watch<TextThemeCubit>().state.textTheme ==
                          TextThemes.light,
                      onToggle: (val) {
                        context.read<TextThemeCubit>().changeTextTheme();
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
