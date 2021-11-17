import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:mobile_ticketing/model/Issue.dart';
import 'package:mobile_ticketing/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String apiUrl = "http://192.168.0.109:8080/v1";
  // final String apiUrl = "https://manifest.ditfrek.postel.go.id/api/v1";
  SharedPreferences? prefs;


  Future<List<Issue>> getIssues(int id) async {
    Response res = await get(Uri.parse(apiUrl +  '/issue?userid=$id' ) );
    List<String> listNo = [];
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Issue> issueList = body.map((dynamic item) => Issue.fromJson(item)).toList();
      issueList.forEach((item) => {
        listNo.add(item.issue_id.toString())
      });
      prefs = await SharedPreferences.getInstance();
      if (prefs!.getStringList('issues') != null) {
        List<String>? listOld = prefs!.getStringList('issues');
        List<int> intIssueNoList = listOld!.map((i) => int.parse(i)).toList();
        if (intIssueNoList.length != 0){
          int lastNum = intIssueNoList.first;
          if (intIssueNoList.first != lastNum){
            listNo.clear();
            issueList.forEach((item) {
              if (item.issue_id > lastNum) listNo.add(item.issue_id.toString());
            });
          }
        }
      }
      prefs!.setStringList('issues', listNo );

      return issueList;
    } else {
      throw "Failed to load Issue list";
    }
  }

  Future<User?>login(TextEditingController login, TextEditingController password) async {
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
      User userModel = User.fromJson(decode_options);
      String user = jsonEncode(userModel);
      prefs = await SharedPreferences.getInstance();
      prefs!.setString('user', user);
      prefs!.setInt('isLogin', 1);
      return User.fromJson(decode_options);
    } else {
      return null;
    }
  }

  Future<bool?>logout() async {
      prefs = await SharedPreferences.getInstance();
      prefs!.clear();
      return true;
  }

  Future<List<int>> getNotif() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? listOld = prefs!.getStringList('issues');
    List<int> intIssueNoList = listOld!.map((i) => int.parse(i)).toList();
    return intIssueNoList;
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
