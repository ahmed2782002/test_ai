import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

/// Serves the real translation files from memory.
///
/// The files are read synchronously, so loading translations never waits on
/// real I/O inside the fake-async zone of a widget test.
class TestAssetLoader extends AssetLoader {
  const TestAssetLoader();

  static final Map<String, Map<String, dynamic>> _cache = {};

  static Map<String, dynamic> translations(String languageCode) {
    return _cache.putIfAbsent(languageCode, () {
      final file = File('assets/translations/$languageCode.json');
      return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    });
  }

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(translations(locale.languageCode));
  }
}
