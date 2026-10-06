part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ChangeState extends ThemeState {
  final ThemeData? theme;
  ChangeState({this.theme});
}
