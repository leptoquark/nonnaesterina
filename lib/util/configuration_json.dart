import 'dart:convert';
import 'package:flutter/services.dart';

class Configuration {
  static Future<String> readProperty(String value) async {
    String data = await rootBundle.loadString('assets/data/config.json');
    data = json.encode(data.toString());
    var jsonData = json.decode(data.toString());
    return jsonData['configurazione'][value];
  }
}
