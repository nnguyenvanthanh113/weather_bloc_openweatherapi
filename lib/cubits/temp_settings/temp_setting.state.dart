import 'package:equatable/equatable.dart';

enum TempUnit {
  Celsius,
  Fahrenheit,
}

class TempSettingState extends Equatable {
  final TempUnit tempUnit;
  const TempSettingState({this.tempUnit = TempUnit.Celsius});
  factory TempSettingState.initial() {
    return const TempSettingState();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [tempUnit];
  @override
  bool get stringify => true;

  TempSettingState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingState(tempUnit: tempUnit = this.tempUnit);
  }

  @override
  String toString() => 'TempSettingsState(tempUnit: $tempUnit)';

  String enumToString() => tempUnit.toString().split('.').last.split(')').first;
}
