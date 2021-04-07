import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_example/entities/gender.dart';

class NameService {

  static List<String> _femaleNames;
  static List<String> _maleNames;
  static Random _random;
  static bool _loadFinished = false;


  static init()  {
    (rootBundle.loadString("assets/femaleNames.txt")).then((value) {
      _femaleNames = value.split("\n");
      if(_maleNames != null){
        _loadFinished = true;
      }
    });
    (rootBundle.loadString("assets/maleNames.txt")).then((value) {
      _maleNames = value.split("\n");
      if(_femaleNames != null ){
        _loadFinished = true;
      }
    });
    _random = Random();
  }

  static bool get namesLoaded => _loadFinished == true;

  static String getRandomName(Gender gender){
    if(_femaleNames != null && _maleNames != null) {
      String name = "";
      if (gender == Gender.male) {
        name += _maleNames[_random.nextInt(_maleNames.length - 1)];
      }
      else {
        name += _femaleNames[_random.nextInt(_femaleNames.length - 1)];
      }
      return name;
    }
    else{
      return "";
    }
  }
}