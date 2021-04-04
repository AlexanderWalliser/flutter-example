import 'package:flutter_example/entities/gender.dart';
import 'package:uuid/uuid.dart';

class Account {
  String id;
  String picturePath;
  String name;
  Gender preferedGender;
  int age;


  Account(this.picturePath, this.name,this.preferedGender,this.age,{String id}): this.id = id ??  Uuid().v4();
  Account copy(){
    return new Account(this.picturePath, this.name,this.preferedGender,this.age, id: id);
  }
}