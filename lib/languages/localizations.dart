import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kotprog/languages/en.dart';
import 'package:kotprog/languages/hu.dart';

class CustomLocalizations {
  final Locale locale;

  CustomLocalizations(this.locale);

  // Segédfüggvény, amivel a BuildContext-ből kikereshetjük a beregisztrált
  // CustomLocalizations példányt, amit a rendszer az épp aktuális nyelvvel
  // példányosít
  static CustomLocalizations of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  static const LocalizationsDelegate<CustomLocalizations> delegate = _CustomLocalizationsDelegate();

  // Hozzárendeljük a nyelv kódjához a definiált szövegeket
  static Map<String, Map<String, String>> _localizedValues = {
    'en': ENGLISH_TEXTS,
    'hu': HUNGARIAN_TEXTS,
  };

  // Az aktuális nyelv alapján adjuk vissza  az azonosítóhoz tartozó
  // lefordított szöveget.
  String stringById(String id) => _localizedValues[locale.languageCode][id];

  // Az egyes azonosítókhoz metódust rendelünk
  String get appName => stringById('appName');
  String get profile => stringById('profile');
  String get newMessageAs => stringById('newMessageAs');
  String get newMessageAnonymous => stringById('newMessageAnonymous');
  String get fieldEmpty => stringById('fieldEmpty');
  String get send => stringById('send');
  String get changeNick => stringById('changeNick');
  String get modify => stringById('modify');
  String get chatCreated => stringById('chatCreated');
  String get createNewChat => stringById('createNewChat');
  String get name => stringById('name');
  String get cancel => stringById('cancel');
  String get ok => stringById('ok');
  String get create => stringById('create');
  String get details => stringById('details');
  String get someError => stringById('someError');
  String get map => stringById('map');
  String get latitude => stringById('latitude');
  String get longitude => stringById('longitude');
  String get sender => stringById('sender');
  String get timestamp => stringById('timestamp');
  String get participants => stringById('participants');
}

// Segédosztály, ami az aktuális nyelv alapján hoz létre egy
// CustomLocalizations példányt, amit majd a widgetekben elérhetünk
// a BuildContexten keresztül
class _CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const _CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hu'].contains(locale.languageCode);

  @override
  Future<CustomLocalizations> load(Locale locale) {
    return SynchronousFuture<CustomLocalizations>(
      CustomLocalizations(locale),
    );
  }

  @override
  bool shouldReload(_CustomLocalizationsDelegate old) => false;
}