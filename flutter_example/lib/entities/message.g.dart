// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    name: json['name'] as String,
    text: json['text'] as String,
    imageUrl: json['imageUrl'] as String,
    author: json['author'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'name': instance.name,
      'text': instance.text,
      'imageUrl': instance.imageUrl,
      'author': instance.author,
    };
