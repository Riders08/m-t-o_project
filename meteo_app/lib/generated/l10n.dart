// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Weather`
  String get appTitle {
    return Intl.message('Weather', name: 'appTitle', desc: '', args: []);
  }

  /// `City not found`
  String get cityNotFound {
    return Intl.message(
      'City not found',
      name: 'cityNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Unable to get your location`
  String get locationError {
    return Intl.message(
      'Unable to get your location',
      name: 'locationError',
      desc: '',
      args: [],
    );
  }

  /// `Major error`
  String get bigError {
    return Intl.message('Major error', name: 'bigError', desc: '', args: []);
  }

  /// `Failed to retrieve data from the API!`
  String get getDataAPIError {
    return Intl.message(
      'Failed to retrieve data from the API!',
      name: 'getDataAPIError',
      desc: '',
      args: [],
    );
  }

  /// `Error while retrieving your location`
  String get getLocationError {
    return Intl.message(
      'Error while retrieving your location',
      name: 'getLocationError',
      desc: '',
      args: [],
    );
  }

  /// `Your location is disabled`
  String get locationNotActive {
    return Intl.message(
      'Your location is disabled',
      name: 'locationNotActive',
      desc: '',
      args: [],
    );
  }

  /// `You did not grant permission to access your location.`
  String get autoriwedLocationError {
    return Intl.message(
      'You did not grant permission to access your location.',
      name: 'autoriwedLocationError',
      desc: '',
      args: [],
    );
  }

  /// `Location permission permanently denied.`
  String get permissionLocationError {
    return Intl.message(
      'Location permission permanently denied.',
      name: 'permissionLocationError',
      desc: '',
      args: [],
    );
  }

  /// `Retrieving your location took too long`
  String get getLocationTimeError {
    return Intl.message(
      'Retrieving your location took too long',
      name: 'getLocationTimeError',
      desc: '',
      args: [],
    );
  }

  /// `City/Country`
  String get place {
    return Intl.message('City/Country', name: 'place', desc: '', args: []);
  }

  /// `Feels like`
  String get feels_like {
    return Intl.message('Feels like', name: 'feels_like', desc: '', args: []);
  }

  /// `5-day forecast`
  String get previsions {
    return Intl.message(
      '5-day forecast',
      name: 'previsions',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
