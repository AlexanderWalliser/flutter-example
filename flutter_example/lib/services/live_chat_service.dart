import 'dart:convert';

import 'package:flutter_example/entities/message.dart';
import 'package:http/http.dart' as http;

class LiveChatService {
  static String _connection = "https://chat.plantastic.at/chat";

  static Future<List<Message>> getLiveMessages() async {
    return http.get(_connection + "").then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        return Future.value(list.map((e) => Message.fromJson(e)).toList());
      } else {
        throw Exception('Failed to load Message');
      }
    });
  }

  static Future<bool> create(Message message) async {
    return http.post(_connection,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(message.toJson())).then((response) {
      if (response.statusCode == 201) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    });
  }
}