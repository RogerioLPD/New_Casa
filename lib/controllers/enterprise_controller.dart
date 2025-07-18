import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:nucleo/model/enterprise_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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
    var url = Uri.https("apicasadecor.com", "/api/usuario/");
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
        if (json.decode(response.body) != []) {
          jsonDecode(utf8.decode(response.bodyBytes));
          item = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
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
        "descricao": "Pioneira no ramo de decoração de ambientes e utilidades, a Dallak Home, está no mercado há 22 anos. Contamos com mais de 50 fornecedores renomados, em destaque as seguintes marcas: Wolff, Strauss, Sant James,velas Voluspa, Copa&amp;Cia, Cristais Bohemia, quadrosArtimage, cachepôs Bella Art, cristais murano São Marcos,plantas e flores permanentes Brilhance, entre outros.",
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
        "descricao": "A FERROPAR é uma empresa que atua em Guarapuava há 12 anos na Avenida Professor Pedro Carli, 4568, na Vila Carli e se consolidou como fabricante de telhas de aço e distrbuidora de ferro.Tem como objetivo trazer variedade de materiais, com diferentes opções de escolha na hora da obra, além disso, por ser fabricante tem flexibilidade nos modelos, tamanhos e cores na telha de aço, que pode ser usada tanto na cobertura, como em projetos arquitetônicos de fachadas, móveis e tudo que sua criatividade permitir.",
        "imagem": "https://drive.google.com/uc?export=view&id=1jFXgkh5K6PM6SIwPi4sGnkP6D6jE2WFc",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Construtora Gutierrez",
        "descricao":
            "Construtora Gutierrez fundada em 2014 em Irati, buscando atender uma alta demanda industrial em Guarapuava, transferiu sua sede em 2017 e desde então atua na região. Especializada em obras de terraplanagem, pavimentação em asfalto e concreto armado, obras civis de infraestrutura, industrial e comercial.",
        "imagem": "https://drive.google.com/uc?export=view&id=16NDVoBkdQ11Gb1yU77rqtV9K41CslywP",
        "cidade": "Guarapuava"
      },
      {
        "nome": "HR Pisos",
        "descricao":
            "A HR Pisos está presente no mercado de pisos laminados desde o ano 2000, oferecendo uma ampla variedade no segmento de pisos laminados, pisos vinílicos, rodapés de MDF e Poliestireno, persianas e grama sintética, trabalhando com diversas marcas nacionais e importadas.",
        "imagem": "https://drive.google.com/uc?export=view&id=1D0NtmcjADKnNG2Ivoa0_KCkaO8CAmH3V",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Kazza acabamentos",
        "descricao":
            "Inaugurada em setembro de 2019, a Kazza Acabamentos é uma loja exclusiva, com o melhor em acabamentos, marcas e modelos exclusivos que inspiraram boas ideias.Nosso Objetivo com o Núcleo é Estreitar ainda mais as Parcerias com os Arquitetos. Estamos com Diversas Marcas Exclusivas como: Kohler, Castelatto, Asper, Zen Puxadores, Derosso,Rubinettos, Vesta, Doka E Também com as Diversas Marcas Renomadas do Mercado Portinari, Porcelanosa, Roca, Ceusa, Delta, Deca, Docol, Durafloor, Quick Step, Jacuzzi, e muitas outras.",
        "imagem": "https://drive.google.com/uc?export=view&id=1qOnEN5RxtDPZIg7VjtDyXYEdmCVQVIFy",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Montello",
        "descricao":
            "A Montello iniciou suas atividades há oito anos em Guarapuava, em agosto de 2015. Atualmente conta com um espaço de 1.400m², 39 colaboradores e um processo de produção próprio e totalmente automatizado. Além dos móveis que são 100% MDF, faz estruturas de ferros, portas de vidro e Portas Provençais em pintura lacca. Nossos principais parceiros: Duratex, Arauco, Guararapes, Berneck, Ferragens BLUM, Puxadores Zen, Alternativa Perfis, RomaLacca e Grupo GMAD.",
        "imagem": "https://drive.google.com/uc?export=view&id=1QpDyL9fSfE4lAOQEr8dCNfsWm8jEklh3",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Raltec Energia Solar",
        "descricao":
            "Especializada em Energia Solar Fotovoltaica, conta com a Matriz em Guarapuava, filial administrativa em Mato Grosso e representantes comerciais atuantes nos estados do Rio Grande do Sul, Santa Catarina, Paraná, São Paulo e Distrito Federal. Atuante em todo o território nacional com mais de 400 usinas instaladas e monitoradas, com certificação 4 estrelas da WEG.",
        "imagem": "https://drive.google.com/uc?export=view&id=1s2EGIS5MNXZuSBYpYD0A4e1g__RgKpnA",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Splash",
        "descricao": "A Splash Piscinas faz parte da rede iGUi, a maior fabricante de piscinas em fibra de vidro do mundo. Com mais de 12 anos de mercado, a marca vende os modelos tradicionais de piscinas mantendo a tecnologia, e qualidade original dos produtos. Com isso, aliado a preços competitivos, a Splash cresceu rápido e se tornou a segunda marca mais vendida do Brasil no seu ramo.",
        "imagem": "https://drive.google.com/uc?export=view&id=1V4wTsIJ17-139zFBzSmJQtp5IpphHDxi",
        "cidade": "Guarapuava"
      },
      {
        "nome": "Vidrocor",
        "descricao":
            "A Vidrocor é uma empresa do ramo vidreiro que atua há mais de 10 anos no mercado, com a fabricação de Esquadria de alumínio, Portas em alumínio e ACM, Pele de vidro e Vidro temperado.",
        "imagem": "https://drive.google.com/uc?export=view&id=1YFxWaL3lsBc8hiR8Rt3Ogj7p_hreH99r",
        "cidade": "Guarapuava"
      }
    ]);
  }
}