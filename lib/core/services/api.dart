// FLUTTER AND THIRD-PARTIES
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Constants
import 'package:UI/core/constants/constants.dart';
import 'package:UI/core/models/user.dart';

// MODELS
import 'package:UI/core/models/employer.dart';
import 'package:UI/core/models/student.dart';

/// Service use to call the API
class Api {
  var client = new http.Client();

  /// Get user data from the API
  /// @param uuid UUID of the user
  /// @return [Student] or [Employer]
  Future<User> getUserInfo({@required String uuid}) async {
    var response = await client.get(Constants.GET_USER.replaceFirst('{uuid}', uuid));

    var json = jsonDecode(response.body);

    if(response.statusCode == 202)
      return json['type'] == 1 ? Student.fromJson(json):Employer.fromJson(json);
    return null;
  }

  /// Create OR update  a student on the server side
  /// @param [Student] student to parse on json
  /// @return boolean true if the creation is a success
  Future<bool> addStudent({@required Student user}) async {
    var response = await client.post(Constants.ADD_STUDENT, body: jsonEncode(user));

    if(response.statusCode == 200)
      return true;
    return false;
  }

  /// Create OR update a employer on the server side
  /// @param [Employer] student to parse on json
  /// @return boolean true if the creation is a success
  Future<bool> addEmployer({@required Employer user}) async {
    var response = await client.post(Constants.ADD_EMPLOYER, body: jsonEncode(user));

    if(response.statusCode == 200)
      return true;
    return false;
  }

  /// Get the list of student a employer "faved"
  /// @param uuid of the employer
  /// @return List of [Student] or null if the employer isn't employer
  Future<List<Student>> getEmployerFavorites(String uuid) async {
    var response = await client.get(Constants.GET_FAVORITES.replaceFirst('{uuid}', uuid));

    var json = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return json.map((i) => Student.fromJson(i)).toList();
    }
    return null;
  }
}