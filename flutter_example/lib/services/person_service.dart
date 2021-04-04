import 'dart:convert';
import 'package:flutter_example/entities/person.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PersonService {

  static int count = 1;
  static Future<Person> getPerson(String gender) async {
    var response = await http.get(
      Uri.encodeFull("https://fakeface.rest/face/json?gender=" +
          gender +
          "&minimum_age=18&maximum_age=35"),
    );
    if (response.statusCode == 200) {
      Person person = Person.fromJson(json.decode(response.body));
      person.id = Uuid().v4();
      person.name = "Test" + (count++).toString();
      person.messages = [];
      return person;
    } else {
      throw Exception('Failed to load Image');
    }
  }
}
