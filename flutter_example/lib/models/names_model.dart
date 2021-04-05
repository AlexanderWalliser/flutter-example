



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/entities/gender.dart';

class NameModel extends ChangeNotifier{

  List<String> _femaleNames;
  List<String> _maleNames;
  List<String> _surname;
  Random _random;

  NameModel()  {
    (rootBundle.loadString("assets/femaleNames.txt")).then((value) => {
      this._femaleNames = value.split("\r\n")
    });
    (rootBundle.loadString("assets/maleNames.txt")).then((value) => {
      this._maleNames = value.split("\r\n")
    });
    (rootBundle.loadString("assets/surNames.txt")).then((value) => {
      this._surname = value.split("\r\n")
    });
    _random = Random();
  }

  String getRandomName(Gender gender){
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