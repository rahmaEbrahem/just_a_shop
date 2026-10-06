import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel {
  @HiveField(0)
  final String languagecode;
  @HiveField(1)
  final String themeMode;
  SettingsModel({required this.languagecode, required this.themeMode});
}
