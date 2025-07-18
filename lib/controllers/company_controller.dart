import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:nucleo/model/enterprise_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CompanyController  {
  StreamController<List<EnterpriseItem>> userListController =
      StreamController.broadcast();
       StreamController<List<String>> cityController = StreamController.broadcast();
  StreamController<bool> isLoadingController = StreamController.broadcast();
  StreamController<bool> isLoadingSearch = StreamController.broadcast();
 

  List<EnterpriseItem> userList = [];

  EnterpriseListController() {
    initValues();
  }

  initValues() async {
    await getData();
     isLoadingSearch.sink.add(false);
  }

 Future<void> getData() async {
    isLoadingController.sink.add(true);
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    var url = Uri.https("apicasadecor.com", "/api/usuario/");
    Map<String, String> headers = {
      'Authorization': "Token $token",
    };

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        if (json.decode(response.body) != []) {
          jsonDecode(utf8.decode(response.bodyBytes));
          userList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
              .map((data) => EnterpriseItem.fromJson(data))
              .where((user) => user.tipo == "EMPRESA") // Filtra apenas usuários do tipo "EMPRESA"
              .map((filteredUser) => EnterpriseItem(
                    // Construa um novo objeto EnterpriseItem com os dados desejados
                    photo: filteredUser.photo,
                    name: filteredUser.name,
                    
                    city: filteredUser.city,
                  ))
              .toList();

          userListController.sink.add(userList);
        }
      } else {
        // Trate casos onde a resposta não seja 200
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoadingController.sink.add(false);
    }
  }
  
}