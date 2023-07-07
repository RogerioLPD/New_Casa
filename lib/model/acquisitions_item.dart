class AcquisitionsItem {
  String? valor;
  Enterprise? empresa;

  AcquisitionsItem({this.valor, this.empresa});

  AcquisitionsItem.fromJson(Map<String, dynamic> json) {
    valor = json['valor'];
    empresa =
    json['empresa'] != null ? Enterprise.fromJson(json['empresa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valor'] = valor;
    if (empresa != null) {
      data['empresa'] = empresa!.toJson();
    }
    return data;
  }
}

class Enterprise {
  String? photo;
  String? firstName;
  String? lastName;
  String? email;
  String? type;

  Enterprise({this.photo, this.firstName, this.lastName, this.email, this.type});

  Enterprise.fromJson(Map<String, dynamic> json) {
    photo = json['foto'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    type = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foto'] = photo;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['tipo'] = type;
    return data;
  }
}