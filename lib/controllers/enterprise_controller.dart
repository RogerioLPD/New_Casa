import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:nucleo/model/enterprise_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../urlBase.dart';

class EnterpriseController {
  StreamController<List<EnterpriseItem>> dataController =
      StreamController.broadcast();
  StreamController<List<String>> cityController = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();
  StreamController<bool> isLoadingSearch = StreamController.broadcast();
  List<EnterpriseItem> itemSecondary = [];

  EnterpriseController() {
    initValues();
  }
  List<EnterpriseItem> item = [];

  initValues() async {
    await getData();
    isLoadingSearch.sink.add(false);
  }

  getData() async {
    isLoading.sink.add(true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //String token = sharedPreferences.getString('token')!;
    var url = Uri.parse("${urlBase}/api/empresas/");
    Map<String, String> headers = {
      //'Authorization': token,
  
    };
    List<String> city = [];
    // Map<String, dynamic> body = {
    //   "username": _emailController.text,
    //   "password": _senhaController.text,
    // };
    city.add("Selecionar");
    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          jsonDecode(utf8.decode(response.bodyBytes));
          item = (json.decode(mockData()) as List)
              .map((data) => EnterpriseItem.fromJson(data))
              .toList();

          dataController.sink.add(item);

          for (EnterpriseItem data in item) {
            if (!city.contains(data.city)) {
              city.add(data.city!);
            }
          }
          cityController.sink.add(city);
          isLoading.sink.add(false);
          // if (kDebugMode) {
          //   print(response.body);
          // }

        }
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  makeSearchBox(value) async {
    itemSecondary.clear();

    if (value == null || value == "Selecionar") {
      dataController.sink.add(item);
    } else {
      for (EnterpriseItem data in item) {
        if (data.city == value) {
          itemSecondary.add(data);
        }
      }
      dataController.sink.add(itemSecondary);
    }
  }

  mockData() {
    return json.encode([
      {
        "nome": "Ambiente Gesso",
        "descricao":"A Ambiente Gesso foi constituída em 2015, com o objetivo de prestar serviços para a cidade de Guarapuava e região, na área de gesso acartonado (dry wall), steel frame, molduras, sancas, revestimentos, fachadas externas em cimentícia, xps e eps, isolamentos térmicos e acústicos e designer de ambientes.",
        "imagem":"https://drive.google.com/uc?export=view&id=1vNqDJtQhTt40OWQMza8yfQgEyhK6iaVI",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Dallak Home",
        "descricao": "Loja especializada em decoração",
        "imagem": "https://drive.google.com/uc?export=view&id=10S1n_nHbXgyUh3YgP3TqL4H_R4IglwTB",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Espaço Das Tintas",
        "descricao":
            "Somos uma loja tradicionalmente Guarapuavana, que tem como essência o cuidado com a qualidade dos produtos vendidos. Colocamos amor em tudo o que fazemos e demontramos ele através do nosso atendimento, que é personalizado e focado em ajudar com as melhores soluções em tintas. Possuímos uma variedade de cores das melhores marcas, possibilitando liberdade na hora de escolher a cor, deixando sua experiência ainda melhor e mais distinta!",
        "imagem": "https://drive.google.com/uc?export=view&id=11TA12sHEpQTsGnRhs0ZicZXudot2h9Rg",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Ferropar",
        "descricao": "Ferro, aço telha termoacústica.",
        "imagem": "https://drive.google.com/uc?export=view&id=1jFXgkh5K6PM6SIwPi4sGnkP6D6jE2WFc",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Construtora Gutierrez",
        "descricao":
            "Somos uma construtora Iratiense, com sede em Guarapuava. Atuamos no desenvolvimento e construção de empreendimentos imobiliários e industriais.",
        "imagem": "https://drive.google.com/uc?export=view&id=16NDVoBkdQ11Gb1yU77rqtV9K41CslywP",
        "cidade": "Guarapuava"
      },
      {
        "nome": "HR Pisos",
        "descricao":
            "Possuimos um amplo Show room de pisos em nossa loja. Faça-nos uma visita e conheça mais os produtos e serviços que oferecemos, temos certeza que aqui irá encontrar o piso perfeito para o seu ambiente.",
        "imagem": "https://drive.google.com/uc?export=view&id=1D0NtmcjADKnNG2Ivoa0_KCkaO8CAmH3V",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Kazza acabamentos",
        "descricao":
            "Loja especializada em materiais de construção e acabamentos",
        "imagem": "https://drive.google.com/uc?export=view&id=1qOnEN5RxtDPZIg7VjtDyXYEdmCVQVIFy",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Montello",
        "descricao":
            "Projetamos o ambiente dos seus sonhos, com fabricação própria dos móveis e a garantia de prazo e qualidade para você!",
        "imagem": "https://drive.google.com/uc?export=view&id=1QpDyL9fSfE4lAOQEr8dCNfsWm8jEklh3",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Raltec Energia Solar",
        "descricao":
            "A Raltec desenvolve sistemas conectados a rede pública, permitindo a redução do consumo e do valor pago às distribuidoras. Além disso, a geração excedentepode ser comercializada com a rede.",
        "imagem": "https://drive.google.com/uc?export=view&id=1s2EGIS5MNXZuSBYpYD0A4e1g__RgKpnA",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Splash",
        "descricao": "Splash Piscinas",
        "imagem": "https://drive.google.com/uc?export=view&id=1V4wTsIJ17-139zFBzSmJQtp5IpphHDxi",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Vidrocor",
        "descricao":
            "A Vidrocor é sinônimo de qualidade, resistência e beleza,Há mais de 8 anos no mercado trazendo o que há melhor e mais moderno do setor vidreiro.Nossas esquadrias possuem um excelente acabamento e são fabricadas sob medida para cada cliente, garantindo assim um resultado exclusivo e personalizado. Com atendimento personalizado, para entender melhor sua necessidade e projeto. Surpreenda-se com a qualidade e o bom atendimento.",
        "imagem": "https://drive.google.com/uc?export=view&id=1YFxWaL3lsBc8hiR8Rt3Ogj7p_hreH99r",
        "cidade": "Guarapuava"
      }
    ]);
  }
}