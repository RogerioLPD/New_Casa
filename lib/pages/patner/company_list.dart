import 'package:flutter/material.dart';
import 'package:nucleo/model/enterprise_item.dart';
import 'package:nucleo/controllers/company_controller.dart'; // Caminho corrigido

class CompanyListPage extends StatefulWidget {
  const CompanyListPage({Key? key}) : super(key: key);

  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  final _companyController = CompanyController();

  @override
  void initState() {
    super.initState();
   _companyController.initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empresas'),
      ),
      body: StreamBuilder<List<EnterpriseItem>>(
        stream: _companyController.userListController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final companies = snapshot.data!;
            return ListView.builder(
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];
                return const ListTile(
                 /* leading: CircleAvatar(
                    backgroundImage: NetworkImage(company.photo),
                  ),
                  title: Text(company.name),
                  subtitle: Text(company.city),*/
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar empresas'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
