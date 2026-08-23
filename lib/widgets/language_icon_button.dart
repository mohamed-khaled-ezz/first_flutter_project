import 'package:flutter/material.dart';
import '../main.dart';

/// A reusable action button to toggle the app's locale between English and Arabic.
class LanguageIconButton extends StatelessWidget {
  const LanguageIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.language),
      onPressed: () {
        // Get the current locale from the context
        final currentLocale = Localizations.localeOf(context);

        // Toggle between 'en' and 'ar'
        final newLocale = currentLocale.languageCode == 'en'
            ? const Locale('ar')
            : const Locale('en');

        // Update the app's state via the static helper in MyApp
        MyApp.of(context)?.setLocale(newLocale);
      },
    );
  }
}
