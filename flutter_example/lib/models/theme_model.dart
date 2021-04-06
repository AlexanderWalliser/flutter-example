import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData _light;
  ThemeData _dark;
  bool _isLight;

  ThemeModel() {
    this._light = ThemeData.light();
    this._dark = ThemeData.dark();
    _isLight = true;
    _save().then((value) => notifyListeners());
  }

  Future _save() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", _isLight);
  }

  Future load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLight = prefs.get("theme") ??  _isLight;
  }

  void toggleTheme() {
    _isLight = ! _isLight;
    _save().then((value) => notifyListeners());
  }

  ThemeData getTheme() {
    return _isLight ? _light : _dark;
  }
}
