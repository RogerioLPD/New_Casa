import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class ReleasesController {
  Future doRelease({required valor, required doc, required empresa}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token')!;
    var url =
        Uri.parse("https://apicasadecor.com/api/nova-compra/");

    Map<String, String> headers = {
      'Authorization': "Token $token",
    };

    var body = <String, dynamic>{
      "valor": valor,
      "doc": doc
    };

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}