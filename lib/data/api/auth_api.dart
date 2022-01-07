import 'package:fabrishop/data/models/server_response.dart';
import 'package:fabrishop/ui/constants/api_constants.dart';
import 'package:fabrishop/ui/constants/shared_constants.dart';
import 'package:fabrishop/ui/constants/shared_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthApi {
  Future<ServerResponse> login({
    @required String email,
    @required String password,
  }) async {
    final url = "${ApiConstants.domain}api/v1/login";
    print(url);
    final body = jsonEncode({"email": email, "password": password});
    print(body);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print(parsed);
      final email = parsed['email'] as String;
      final name = parsed['first_name'] as String;
      final lastname = parsed['last_name'] as String;
      final id = parsed['id'] as int;
      final storeId = parsed['store_id'] as int;
      PreferenceUtils.setString(SharedConstants.fullname, name);
      PreferenceUtils.setString(SharedConstants.lastname, lastname);
      PreferenceUtils.setString(SharedConstants.email, email);
      PreferenceUtils.setInt(SharedConstants.userId, id);
      PreferenceUtils.setInt(SharedConstants.storeId, storeId);

      return ServerResponse(
        status: true,
        statusCode: 200,
      );
    } else {
      return ServerResponse(
        status: false,
        message: "Correo o contraseña incorrecta. ¡Intenta de nuevo!.",
        statusCode: response.statusCode,
      );
    }
  }
}
