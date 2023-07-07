class EnterpriseItem {
  String? photo;
  String? name;
  String? description;
  String? city;

  EnterpriseItem({this.photo, this.name, this.description, this.city});

  EnterpriseItem.fromJson(Map<String, dynamic> json) {
    photo = json['imagem'];
    name = json['nome'];
    description = json['descricao'];
    city = json['cidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imagem'] = photo;
    data['nome'] = name;
    data['descricao'] = description;
    data['cidade'] = city;
    return data;
  }
}
