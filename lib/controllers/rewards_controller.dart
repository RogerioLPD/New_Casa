import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:nucleo/pages/premios/viagem_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RewardsController {
  StreamController<List<ProductItem>> dataController =
      StreamController.broadcast();

  RewardsController() {
    initValues();
  }

  initValues() async {
    await getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //String token = sharedPreferences.getString('token')!;
    var url = Uri.https("apicasadecor.com", "/api/premio/");
    Map<String, String> headers = {
      'content-type': 'application/json',
    };
    List<ProductItem> item = [];
    // Map<String, dynamic> body = {
    //   "username": _emailController.text,
    //   "password": _senhaController.text,
    // };
    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        if (json.decode(response.body) != []) {
          item = (json.decode(response.body) as List)
              .map((data) => ProductItem.fromJson(data))
              .toList();
          dataController.sink.add(item);
        }
        // if (kDebugMode) {
        //   print(token);
        // }
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }
}