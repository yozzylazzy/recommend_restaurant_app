import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getRandomRestoNotification();
  }

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  bool _isRandomRestoNotification = false;

  bool get isRandomRestoNotification => _isRandomRestoNotification;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getRandomRestoNotification() async {
    _isRandomRestoNotification =
        await preferencesHelper.isRandomRestoNotificationActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableRandomRestoNotification(bool value) {
    preferencesHelper.setRandomRestoNotification(value);
    _getRandomRestoNotification();
  }
}
