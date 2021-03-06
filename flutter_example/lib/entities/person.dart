import 'package:flutter_example/entities/entity.dart';
import 'package:flutter_example/entities/message.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'gender.dart';
part 'person.g.dart';

@JsonSerializable()
class Person implements Entity{
  String id;
  String name;
  int age;
  Gender gender;
  @JsonKey(name: "image_url")
  String imageUrl;
  List<Message> messages;


  Person(this.name, this.imageUrl, this.age, this.gender): id =  Uuid().v4(), messages = [];

  @override
  bool operator ==(Object other) {
    if (other is Person) {
      return this.id == other.id;
    }else{
      return false;
    }
  }



  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);

}

