// FLUTTER
import 'dart:convert';

import 'package:UI/core/models/employer.dart';
import 'package:UI/core/models/student.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Constants
import 'package:UI/core/constants/constants.dart';
import 'package:UI/core/models/user.dart';

/// Service use to call the API
class Api {
  var client = new http.Client();

  /// Get user data from the API
  /// @param uuid UUID of the user
  /// @return [Student] or [Employer]
  Future<User> getUserInfo({@required String uuid}) async {
    //var response = await client.get(Constants.GET_USER.replaceFirst('{uuid}', uuid));

    //var json = jsonDecode(response.body);
    var json = jsonDecode('{"type":1,"uuid": "3fa85f64-5717-4562-b3fc-2c963f66afa6","firstname": "John","lastname": "Doe","email": "user@example.com","availabilities": [{"date": "2020-04-25","duration": 0}],"appointments": [{"timeSlot": {"date": "2020-04-25","duration": 0},"studentuuid": "3fa85f64-5717-4562-b3fc-2c963f66afa6","employeruuid": "3fa85f64-5717-4562-b3fc-2c963f66afa6","url": "string"}],"picture": "string","CV": "string","tags": [{"name": "Flutter","description": "A true cross-platform development framework"}],"isAvailable": true,"jobType": ["INTERNSHIP"]}');

    //if(response.statusCode == 202)
      return json['type'] == 1 ? Student.fromJson(json):Employer.fromJson(json);
    //return null;
  }
}