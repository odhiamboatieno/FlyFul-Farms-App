import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    )!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [
    Locale('en'),
    Locale('sw'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Flyful Farms',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'phone': 'Phone Number',
      'password': 'Password',
      'name': 'Full Name',
      'forgotPassword': 'Forgot Password?',
      'dontHaveAccount': 'Don\'t have an account? Register',
      'alreadyHaveAccount': 'Already have an account? Login',
      'backToLogin': 'Back to Login',
      'sendResetLink': 'Send Reset Link',
      'dashboard': 'Dashboard',
      'batches': 'Batches',
      'breeding': 'Breeding',
      'harvest': 'Harvest',
      'inventory': 'Inventory',
      'reports': 'Reports',
      'profile': 'Profile',
      'settings': 'Settings',
      'logout': 'Logout',
      'save': 'Save',
      'cancel': 'Cancel',
      'submit': 'Submit',
      'loading': 'Loading...',
    },
    'sw': {
      'appTitle': 'Flyful Farms',
      'login': 'Ingia',
      'register': 'Sajili',
      'email': 'Barua pepe',
      'phone': 'Namba simu',
      'password': 'Neno la siri',
      'name': 'Jina kamili',
      'forgotPassword': 'Umesahau neno la siri?',
      'dontHaveAccount': 'Huna akaunti? Sajili',
      'alreadyHaveAccount': 'Tuna akaunti? Ingia',
      'backToLogin': 'Rudia kwenye Ingia',
      'sendResetLink': 'Tuma kiungo cha urekebishaji',
      'dashboard': 'Dashibodi',
      'batches': 'Vitafunwa',
      'breeding': 'Kukuza',
      'harvest': ' mavuno',
      'inventory': ' Hifadhidata',
      'reports': 'Ripoti',
      'profile': 'Wasifu',
      'settings': 'Mipangilio',
      'logout': 'Toa',
      'save': 'Hifadhi',
      'cancel': 'Ghairi',
      'submit': 'Wasilisha',
      'loading': 'Inapakia...',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  static String tr(BuildContext context, String key) {
    return AppLocalizations.of(context).translate(key);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'sw'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
