



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/entities/gender.dart';

class NameModel {

  static List<String> _femaleNames;
  static List<String> _maleNames;
  static List<String> _surname;
  static Random _random;
  static bool _loadFinished = false;


  static init()  {
    (rootBundle.loadString("assets/femaleNames.txt")).then((value) {
      _femaleNames = value.split("\r\n");
      if(_maleNames != null && _surname != null){
        _loadFinished = true;
      }
    });
    (rootBundle.loadString("assets/maleNames.txt")).then((value) {
      _maleNames = value.split("\r\n");
      if(_femaleNames != null && _surname != null){
        _loadFinished = true;
      }
    });
    (rootBundle.loadString("assets/surNames.txt")).then((value) {
      _surname = value.split("\r\n");
      if(_maleNames != null && _femaleNames != null){
        _loadFinished = true;
      }
    });
    _random = Random();
  }

  static bool get namesLoaded => _loadFinished == true;

  static String getRandomName(Gender gender){
    if(_femaleNames != null && _maleNames != null && _surname != null) {
      String name = "";
      if (gender == Gender.male) {
        name += _maleNames[_random.nextInt(_maleNames.length - 1)];
      }
      else {
        name += _femaleNames[_random.nextInt(_femaleNames.length - 1)];
      }
      name += " " + _surname[_random.nextInt(_surname.length - 1)];
      return name;
    }
    else{
      return "";
    }
  }
}