import 'package:flutter_example/entities/gender.dart';

class Account {
  String picturePath;
  String name;
  Gender preferedGender;
  int age;


  Account(this.picturePath, this.name,this.preferedGender,this.age);
  Account copy(){
    return new Account(this.picturePath, this.name,this.preferedGender,this.age);
  }

  void set(Account account) {
    this.picturePath = account.picturePath;
    this.name = account.name;
    this.preferedGender = account.preferedGender;
    this.age = account.age;
  }
}