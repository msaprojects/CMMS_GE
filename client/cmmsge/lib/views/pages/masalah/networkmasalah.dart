import 'dart:convert';

import 'package:cmmsge/services/models/masalah/masalahModel.dart';
import 'package:cmmsge/services/utils/apiService.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

final String _apiService = ApiService().BaseUrl;
List<MasalahModel> parseSite(String responseBody) {
  var listSite = json.decode(responseBody)['data'] as List<dynamic>;
  return listSite.map((e) => MasalahModel.fromJson(e)).toList();
}

Future<List<MasalahModel>> fetchMasalah(
    String token, String flag_activity) async {
  var url = Uri.parse(_apiService + 'masalah/' + flag_activity);
  print(url);
  var response = await http.get(url, headers: {
    'content-type': 'application/json',
    // ++ fyi : sending token with BEARER
    'Authorization': 'Bearer ' + token
  });
  print(response.statusCode);
  if (response.statusCode == 200) {
    return compute(parseSite, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}
