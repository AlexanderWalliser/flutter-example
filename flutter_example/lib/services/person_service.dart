import 'dart:convert';
import 'package:flutter_example/entities/account.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/models/names_model.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PersonService {

  static Future<Person> getPerson(Account account) async {
    var response = await http.get(
      Uri.encodeFull("https://fakeface.rest/face/json?gender=" +
          account.preferedGender.toString().split(".").last +
          "&minimum_age=18&maximum_age="+ (account.age + 5).toString()),
    );
    if (response.statusCode == 200) {
      Person person = Person.fromJson(json.decode(response.body));
      person.id = Uuid().v4();
      person.name = NameModel.getRandomName(account.preferedGender);
      person.messages = [];
      return person;
    } else {
      throw Exception('Failed to load Image');
    }
  }
}
