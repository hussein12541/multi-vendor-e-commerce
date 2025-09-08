part of 'theme_and_local_cubit.dart';

@immutable
class ThemeAndLocalState {
  final bool isDark;
  final String locale;

  const ThemeAndLocalState({
    this.isDark = false,
    this.locale = "en",
  });

  ThemeAndLocalState copyWith({
    bool? isDark,
    String? locale,
  }) {
    return ThemeAndLocalState(
      isDark: isDark ?? this.isDark,
      locale: locale ?? this.locale,
    );
  }
}
