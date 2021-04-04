import 'package:flutter_example/entities/entity.dart';
import 'package:flutter_example/entities/gender.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account implements Entity {
  String id;
  String picturePath;
  String name;
  Gender preferedGender;
  int age;


  Account(this.picturePath, this.name,this.preferedGender,this.age,{String id}): this.id = id ??  Uuid().v4();
  Account copy(){
    return new Account(this.picturePath, this.name,this.preferedGender,this.age, id: id);
  }

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}