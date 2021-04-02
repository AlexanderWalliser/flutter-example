import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'person.g.dart';

@JsonSerializable()
class Person{
  String id;
  String name;
  int age;
  String gender;
  @JsonKey(name: "image_url")
  String imageUrl;


  Person(this.name, this.imageUrl, this.age, this.gender): id =  Uuid().v4();

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

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);

}

