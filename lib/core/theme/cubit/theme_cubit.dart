import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/storage/settings_model.dart';
import 'package:e_commerce_app/core/storage/settings_storage.dart';
import 'package:e_commerce_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this.settingsStorage) : super(ThemeInitial());
  final SettingsStorage settingsStorage;
  ThemeData apptheme = AppTheme.lightthem;

  Future<void> changemode() async {
    if (apptheme == AppTheme.lightthem) {
      apptheme = AppTheme.darkthem;
    } else {
      apptheme = AppTheme.lightthem;
    }
    final settings = settingsStorage.getSettings();
    final updatedSettings = SettingsModel(
      languagecode: settings?.languagecode ?? 'en',
      themeMode: apptheme == AppTheme.darkthem ? 'dark' : 'light',
    );
    await settingsStorage.SaveSettings(updatedSettings);
    emit(ChangeState(theme: apptheme));
  }

  Future<void> setTheme(String themeMode) async {
    if (themeMode == 'dark') {
      apptheme = AppTheme.darkthem;
    } else {
      apptheme = AppTheme.lightthem;
    }
    emit(ChangeState(theme: apptheme));

    final settings = settingsStorage.getSettings();

    final updatedSettings = SettingsModel(
      languagecode: settings?.languagecode ?? 'en',
      themeMode: themeMode,
    );

    await settingsStorage.SaveSettings(updatedSettings);
  }

  void getSavedTheme() {
    final settings = settingsStorage.getSettings();
    if (settings?.themeMode == 'dark') {
      apptheme = AppTheme.darkthem;
    } else {
      apptheme = AppTheme.lightthem;
    }
    emit(ChangeState(theme: apptheme));
  }
}
