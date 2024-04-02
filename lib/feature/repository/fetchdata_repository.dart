import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../model/restuarant_model.dart';

final fetchDataRepositoryProvider = Provider((ref) {
  return FetchDataRepository();
});

class FetchDataRepository{
  Future<Restaurants> fetchRestaurants() async {
    var datas;

    final response = await http.get((Uri.parse(
        "https://firstflight-web.ipixsolutions.net/api/getRestaurants")));
    print(response.statusCode);
    print("response.body-------------${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      datas = Restaurants.fromJson(data);
      // _resto = Restaurants.fromJson(data);
    } else {
      print("error");
    }
    return datas;
  }
}