class EnterpriseItem {
  String? photo;
  String? name;
  String? city;
  String? tipo; // Adicionando o campo 'tipo' ao modelo

  EnterpriseItem({this.photo, this.name, this.city, this.tipo});

  EnterpriseItem.fromJson(Map<String, dynamic> json) {
    photo = json['foto']; // Corrigindo o nome do campo 'imagem'
    name = json['nome'];
    city = json['cidade'];
    tipo = json['tipo']; // Adicionando a atribuição do campo 'tipo'
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foto'] = photo;
    data['nome'] = name;
    data['cidade'] = city;
    data['tipo'] = tipo; // Adicionando a inclusão do campo 'tipo'
    return data;
  }
}
