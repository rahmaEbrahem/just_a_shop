import 'package:e_commerce_app/core/storage/settings_model.dart';
import 'package:e_commerce_app/e_commerce_app.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsModelAdapter());
  await Hive.openBox<SettingsModel>('settingsBox');
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: Locale('en'),
      child: ECommerceApp(),
    ),
  );
}
