import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_example/entities/message.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/file_storage.dart';

class ThemeModel extends ChangeNotifier{
  ThemeData _light;
  ThemeData _dark;
  ThemeData _current;

  FileStorage _fileStorage;

  ThemeModel(this._fileStorage) {
    this._light = ThemeData.light();
    this._dark = ThemeData.dark();
    _current = _dark;
    load();
  }

  void _save() {
  }
  void load(){

  }

  void toggleTheme(){
    _current = _current == _dark ? _light: _dark;
    _save();
    notifyListeners();
  }

  ThemeData getTheme(){
    return _current;
  }
}