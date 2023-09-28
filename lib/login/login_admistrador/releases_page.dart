import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Purchase {
  final int id;
  final String especificador;
  final String empresa;
  final String valor;
  double get multipliedValue => double.parse(valor) * 1000;
  String get formattedMultipliedValue =>
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(multipliedValue);
     
  Purchase({
    required this.id,
    required this.especificador,
    required this.empresa,
    required this.valor,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      especificador: json['especificador']['nome'],
      empresa: json['empresa']['nome'],
      valor: json['valor'],
    );
  }
}

class ReleasesPage extends StatefulWidget {
  @override
  _ReleasesPageState createState() => _ReleasesPageState();
}

class _ReleasesPageState extends State<ReleasesPage> {
  List<Purchase> _purchases = [];
  double _totalSum = 0.0;
  

  @override
  void initState() {
    super.initState();
    _fetchPurchases();
  }

  Future<void> _fetchPurchases() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token == null) {
      print('Token not available.');
      return;
    }

    var url = Uri.parse("https://apicasadecor.com/api/compra/");
    Map<String, String> headers = {
      'Authorization': "Token $token",
      'content-type': 'application/json',
    };

    try {
      var response = await http.get(url, headers: headers);
if (response.statusCode == 200) {
  var responseBody = utf8.decode(response.bodyBytes); // Decodificar usando UTF-8
  var purchaseData = jsonDecode(responseBody);
  setState(() {
    _purchases = List<Purchase>.from(purchaseData.map((purchaseJson) => Purchase.fromJson(purchaseJson)));
    _calculateTotalSum();
  });
} else {
  print('Failed to fetch purchases.');
}

    } catch (e) {
      print(e.toString());
    }
  }

  void _calculateTotalSum() {
    double sum = 0.0;
    for (var purchase in _purchases) {
      sum += double.parse(purchase.valor) * 1000;
    }
    setState(() {
      _totalSum = sum;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
      ),
      body: _purchases.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _purchases.length,
                    itemBuilder: (context, index) {
                      final purchase = _purchases[index];
                      return ListTile(
                        title: Text('Arquiteto(a): ${purchase.especificador}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Loja: ${purchase.empresa}'),
                            Text('Pontos: ${purchase.valor}'),
                            Text('Valor: ${purchase.formattedMultipliedValue}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Total: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(_totalSum)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}