import 'package:e_commerce_app/core/storage/settings_model.dart';
import 'package:hive_flutter/adapters.dart';

class SettingsStorage {
  final Box<SettingsModel> settingsBox = Hive.box<SettingsModel>('settingsBox');

  Future<void> SaveSettings(SettingsModel settings) async {
    await settingsBox.put('settings', settings);
  }

  SettingsModel? getSettings() {
    return settingsBox.get('settings');
  }
}
