import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetWorkHelper {
  NetWorkHelper({required this.url});

  final url;

  Future getData() async {
    http.Response response = await http.get(url as Uri);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }
}
