import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:mobile_ticketing/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String apiUrl = "http://192.168.0.109:8080";
  SharedPreferences? prefs;

  Future<List<User>> getCases() async {
    Response res = await get(Uri.parse(apiUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<User> users = body.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<bool>login(TextEditingController login, TextEditingController password) async {
    Response res = await post(
      Uri.parse(apiUrl + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'login': login.text,
        'password': password.text
      }),
    );

    if (res.statusCode == 201) {
      Map<String, dynamic> decode_options = jsonDecode(res.body);
      String user = jsonEncode(User.fromJson(decode_options));
      prefs = await SharedPreferences.getInstance();
      prefs!.setString('user', user);
      return true;
    }
    return false;
  }

  /*Future<Cases> getCaseById(String id) async {
    final response = await get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Cases> createCase(Cases cases) async {
    Map data = {
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Cases> updateCases(String id, Cases cases) async {
    Map data = {
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status
    };

    final Response response = await put(
      '$apiUrl/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteCase(String id) async {
    Response res = await delete('$apiUrl/$id');

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }*/

}
