/*import 'package:flutter/material.dart';
import 'package:nucleo/controllers/enterprise_controller.dart';
import 'package:nucleo/model/enterprise_item.dart';

class EnterpriseListPage extends StatefulWidget {
  @override
  _EnterpriseListPageState createState() => _EnterpriseListPageState();
}

class _EnterpriseListPageState extends State<EnterpriseListPage> {
  final EnterpriseController _enterpriseController = EnterpriseController();

  @override
  void initState() {
    super.initState();
    _enterpriseController.initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empresas'),
      ),
      body: StreamBuilder<List<EnterpriseItem>>(
        stream: _enterpriseController.dataController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<EnterpriseItem> enterprises = snapshot.data!;
           // enterprises.sort((a, b) => b.amount.compareTo(a.amount)); // Ordena a lista com base no atributo 'amount'
            return enterprises.isEmpty
                ? const Center(
                    child: Text("Sem Empresas no momento"),
                  )
                : ListView.builder(
                    itemCount: enterprises.length,
                    itemBuilder: (context, index) {
                      EnterpriseItem enterprise = enterprises[index];
                      return ListTile(
                        title: Text(enterprise.name!),
                        subtitle: Text(enterprise.city ?? ''),
                        leading: CircleAvatar(
                          // Carregue a foto da empresa usando a URL ou outro método desejado
                          backgroundImage: NetworkImage(enterprise.photoUrl ?? ''),
                        ),
                        // Adicione mais informações ou personalizações conforme necessário
                        onTap: () {
                          // Adicione a navegação ou ação ao tocar na empresa se necessário
                        },
                      );
                    },
                  );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar dados'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EnterpriseListPage(),
  ));
}
*/