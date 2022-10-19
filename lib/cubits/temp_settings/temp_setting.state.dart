import 'package:equatable/equatable.dart';

enum TempUnit {
  celsius,
  fahrenheit,
}

class TempSettingState extends Equatable {
  final TempUnit tempUnit;
  const TempSettingState({required this.tempUnit});

  @override
  List<Object?> get props => [tempUnit];

  factory TempSettingState.initial() =>
      const TempSettingState(tempUnit: TempUnit.celsius);

  @override
  bool get stringify => true;

  TempSettingState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingState(tempUnit: tempUnit ?? this.tempUnit);
  }

  @override
  String toString() => 'TempSettingsState(tempUnit: $tempUnit)';

  enumToString() => tempUnit.toString().split('.').last.split(')').first;
}
