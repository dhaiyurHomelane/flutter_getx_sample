import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingViewModel extends GetxController
{
  final _getBox = GetStorage();
  final _key = 'isDarkMode';

  final _isDarkMode=false.obs;

  get isDarkMode => _loadThemeFromBox();

  /// Get isDarkMode from local storage
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDarkMode from local storage
  bool _loadThemeFromBox(){
    _isDarkMode.value=_getBox.read(_key) ?? false;
    return _isDarkMode.value;
  }

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _getBox.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    _isDarkMode.value=_loadThemeFromBox();
    Get.changeThemeMode(!_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox(!_isDarkMode.value);
  }
}