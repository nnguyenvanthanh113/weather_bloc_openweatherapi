import 'package:equatable/equatable.dart';

enum TextThemes {
  light,
  dark,
}

class TextThemeState extends Equatable {
  final TextThemes textTheme;
  const TextThemeState({
    required this.textTheme,
  });

  @override
  List<Object> get props => [textTheme];

  factory TextThemeState.initial() =>
      const TextThemeState(textTheme: TextThemes.light);

  TextThemeState copyWith({
    TextThemes? textTheme,
  }) {
    return TextThemeState(
      textTheme: textTheme ?? this.textTheme,
    );
  }

  @override
  String toString() => 'TextThemeState(textTheme: $textTheme)';

  enumToString() => textTheme.toString().split('.').last.split(')').first;
}
