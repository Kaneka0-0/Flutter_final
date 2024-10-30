import 'package:flutter/foundation.dart';
import 'package:final_module/final_module/fakeapi_model.dart';
import 'package:http/http.dart' as http;

class MusicService {
  static Future<List<FakeApiModel>> readAPI() async {
    String url = "https://api.currentsapi.services/v1/latest-news";
    http.Response response = await http.get(Uri.parse(url));
    return compute(fakeApiModelFromJson as ComputeCallback<String, List<FakeApiModel>>, response.body);
  }
}