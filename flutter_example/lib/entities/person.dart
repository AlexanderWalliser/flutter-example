import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class Person{
  String id;
  String name;
  Uint8List picture;
  int age;
  bool gender;


  Person(this.name, this.picture, this.age, this.gender): id =  Uuid().v4();

  @override
  bool operator ==(Object other) {
    if (other is Person) {
      return this.id == other.id;
    }else{
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;
}