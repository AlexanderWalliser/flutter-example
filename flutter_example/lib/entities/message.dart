import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String name;
  String text;
  String imageUrl;
  String author;

  Message({this.name, this.text, this.imageUrl,this.author});


  @override
  int get hashCode => super.hashCode;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
