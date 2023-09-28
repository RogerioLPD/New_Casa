import 'dart:convert';
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
         if (json.decode(response.body) != []) {
          jsonDecode(utf8.decode(response.bodyBytes));
        return true;
         }
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

 Future<List<Map<String, dynamic>>> fetchReleaseData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token')!;
    var url = Uri.parse("https://apicasadecor.com/api/compra/"); // Use o endpoint correto

    Map<String, String> headers = {
      'Authorization': "Token $token",
    };

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> releaseDataList = [];

        for (var release in responseData) {
          releaseDataList.add({
            'especificador': release['especificador']['nome'],
            'empresa': release['empresa']['nome'],
            'valor': release['valor'],
          });
        }

        return releaseDataList;
      } else {
        throw Exception('Erro ao buscar os dados da API');
      }
    } catch (e) {
      throw Exception('Erro ao buscar os dados da API: $e');
    }
  }


}