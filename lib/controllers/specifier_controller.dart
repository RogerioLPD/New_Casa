import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nucleo/model/acquisitions_item.dart';
import 'package:nucleo/model/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SpecifierController {
  final StreamController<List<AcquisitionsItem>> detailsController =
      StreamController.broadcast();
  final StreamController<double> pointsController = StreamController.broadcast();
  final StreamController<UserDetails> userController =
      StreamController.broadcast();

  final PageController pageController = PageController(initialPage: 0);

  SpecifierController() {
    initValues();
  }

  void dispose() {
    detailsController.close();
    pointsController.close();
    userController.close();
  }

  initValues() async {
    await getData();
    await getGetUser();
  }

  Future<void> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    var url = Uri.https("apicasadecor.com", "/api/compras/especificador/");
    Map<String, String> headers = {
      'Authorization': "Token $token",
      'content-type': 'application/json',
    };
    List<AcquisitionsItem> item = [];
    try {
      var response = await http.get(url, headers: headers);
      print('Response ${response.body}');
      if (response.statusCode == 200) {
        if (json.decode(response.body) != []) {
          jsonDecode(utf8.decode(response.bodyBytes));

          item = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
              .map((data) => AcquisitionsItem.fromJson(data))
              .toList();
          double valueTotal = 0;
          for (AcquisitionsItem data in item) {
            double value = double.parse(data.valor!);
            print(data);
            valueTotal += value;
          }

          print(valueTotal);
          pointsController.sink.add(valueTotal); // Não arredonda o valor
          detailsController.sink.add(item);
        }
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getGetUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token')!;
    var url = Uri.https("apicasadecor.com", "/api/usuario/$token");
    Map<String, String> headers = {
      'Authorization': "Token $token",
      'content-type': 'application/json',
    };
    UserDetails item;
    try {
      var response = await http.get(url, headers: headers);
      print('Response ${response.body}');
      if (response.statusCode == 200) {
        if (json.decode(response.body) != []) {
          jsonDecode(utf8.decode(response.bodyBytes));
          item = UserDetails.fromJson(
              jsonDecode(utf8.decode(response.bodyBytes)));

          userController.sink.add(item);
          int valueTotal = 0;
        }
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }
}
