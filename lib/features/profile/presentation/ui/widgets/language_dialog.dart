import 'package:e_commerce_app/core/storage/settings_model.dart';
import 'package:e_commerce_app/core/storage/settings_storage.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  Future<void> _changeLanguage(
    BuildContext context,
    String languageCode,
  ) async {
    final settingsStorage = SettingsStorage();
    final currentSettings = settingsStorage.getSettings();

    await settingsStorage.SaveSettings(
      SettingsModel(
        languagecode: languageCode,
        themeMode: currentSettings?.themeMode ?? 'light',
      ),
    );

    if (!context.mounted) return;

    await context.setLocale(Locale(languageCode));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.locale.languageCode;

    return AlertDialog(
      title: Text(LocaleKeys.chooselanguage.tr()),
      content: RadioGroup<String>(
        groupValue: currentLanguage,
        onChanged: (value) {
          if (value != null) {
            _changeLanguage(context, value);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            RadioListTile<String>(title: Text('English'), value: 'en'),
            RadioListTile<String>(title: Text('العربية'), value: 'ar'),
          ],
        ),
      ),
    );
  }
}
