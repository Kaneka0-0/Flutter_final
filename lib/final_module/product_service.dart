import 'package:flutter/foundation.dart';
import 'package:final_module/final_module/fakeapi_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<FakeApiModel>> readAPI() async {
    String url = "https://api.currentsapi.services/v1/latest-news?apiKey=ymbwobO7NY6x1ozQSo_9SYo5m7pFUGv1yDRT24y4CBdeAbo0";
    http.Response response = await http.get(Uri.parse(url));
    return compute(fakeApiModelFromJson as ComputeCallback<String, List<FakeApiModel>>, response.body);
  }
}